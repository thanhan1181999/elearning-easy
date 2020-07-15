# frozen_string_literal: true

require 'xmlsimple'
require 'aliyun/oss'

# Using Aliyun OSS Ruby SDK
AliyunOssSdk= Aliyun::OSS

module Fog
  module Aliyun
    class Storage < Fog::Service
      DEFAULT_REGION = 'cn-hangzhou'

      DEFAULT_SCHEME = 'https'
      DEFAULT_SCHEME_PORT = {
        'http' => 80,
        'https' => 443
      }.freeze

      recognizes :aliyun_oss_endpoint,
                 :aliyun_oss_location,
                 :aliyun_region_id,
                 :aliyun_oss_sdk_log_path

      requires :aliyun_accesskey_id,
               :aliyun_accesskey_secret,
               :aliyun_oss_bucket

      model_path 'fog/aliyun/models/storage'
      model :directory
      collection :directories
      model :file
      collection :files

      request_path 'fog/aliyun/requests/storage'
      request :copy_object
      request :delete_bucket
      request :delete_object
      request :get_bucket
      request :get_object
      request :get_object_http_url
      request :get_object_https_url
      request :head_object
      request :put_bucket
      request :put_object
      request :list_buckets
      request :list_objects
      request :get_containers
      request :get_container
      request :delete_container
      request :put_container

      class Real
        # Initialize connection to OSS
        #
        # ==== Notes
        # options parameter must include values for :aliyun_accesskey_id, :aliyun_secret_access_key and :aliyun_oss_bucket in order to create a connection.
        # :aliyun_oss_location will be replaced by :aliyun_region_id, and it has a default value cn-hangzhou
        # if :aliyun_oss_endpoint is not specified, it will be generated by method region_to_endpoint
        #
        # ==== Examples
        #   sdb = Fog::Storage.new(:provider=>'aliyun',
        #    :aliyun_accesskey_id => your_:aliyun_accesskey_id,
        #    :aliyun_secret_access_key => your_aliyun_secret_access_key
        #   )
        #
        # ==== Parameters
        # * options<~Hash> - config arguments for connection.  Defaults to {}.
        #
        # ==== Returns
        # * OSS object with connection to aliyun.
        attr_reader :aliyun_accesskey_id
        attr_reader :aliyun_accesskey_secret
        attr_reader :aliyun_oss_endpoint
        attr_reader :aliyun_region_id
        attr_reader :aliyun_oss_bucket
        attr_reader :aliyun_oss_sdk_log_path

        def initialize(options = {})
          # initialize the parameters
          @aliyun_region_id = options[:aliyun_region_id] || options[:aliyun_oss_location] || DEFAULT_REGION
          @aliyun_oss_endpoint = options[:aliyun_oss_endpoint] || region_to_endpoint(@aliyun_region_id)
          @aliyun_accesskey_id = options[:aliyun_accesskey_id]
          @aliyun_accesskey_secret = options[:aliyun_accesskey_secret]
          @aliyun_oss_bucket = options[:aliyun_oss_bucket]
          @aliyun_oss_sdk_log_path=options[:aliyun_oss_sdk_log_path]
          if @aliyun_oss_sdk_log_path && !::File.exist?(@aliyun_oss_sdk_log_path)
            `touch #{@aliyun_oss_sdk_log_path}`
          end
          ENV["ALIYUN_OSS_SDK_LOG_PATH"] = @aliyun_oss_sdk_log_path
          # check for the parameters
          missing_credentials = []
          missing_credentials << :aliyun_oss_bucket unless @aliyun_oss_bucket
          missing_credentials << :aliyun_accesskey_id unless @aliyun_accesskey_id
          missing_credentials << :aliyun_accesskey_secret unless @aliyun_accesskey_secret
          raise ArgumentError, "Missing required arguments: #{missing_credentials.join(', ')}" unless missing_credentials.empty?

          @connection_options = options[:connection_options] || {}

          endpoint = @aliyun_oss_endpoint

          @aliyun_oss_endpoint = "#{DEFAULT_SCHEME}://#{endpoint}" unless endpoint.start_with?(DEFAULT_SCHEME)

          uri = URI.parse(@aliyun_oss_endpoint)
          @host = uri.host
          @path = uri.path
          @scheme = uri.scheme || DEFAULT_SCHEME
          @port = uri.port || DEFAULT_SCHEME_PORT[@scheme]

          @persistent = options[:persistent] || false
          @oss_client = AliyunOssSdk::Client.new(
                                     :endpoint => @aliyun_oss_endpoint,
                                     :access_key_id => @aliyun_accesskey_id,
                                     :access_key_secret => @aliyun_accesskey_secret
          )

          # initiate a aliyun oss ruby sdk config and using sdk http to invoke the OSS openapi
          @oss_config = AliyunOssSdk::Config.new(
              :endpoint => @aliyun_oss_endpoint,
              :access_key_id => @aliyun_accesskey_id,
              :access_key_secret => @aliyun_accesskey_secret
          )
          @oss_http = AliyunOssSdk::HTTP.new(@oss_config)
        end

        def reload
          @connection.reset
        end

        def region_to_endpoint(region = nil)
          case region.to_s
          when ''
            "oss-#{DEFAULT_REGION}.aliyuncs.com"
          else
            "oss-#{region}.aliyuncs.com"
          end
        end

        def request(params)
          method = params[:method]
          time = Time.new.utc
          date = time.strftime('%a, %d %b %Y %H:%M:%S GMT')

          bucket = params[:bucket]
          tmpHost = if bucket
                      bucket + '.' + @host
                    else
                      @host
                    end

          @connection = Fog::Core::Connection.new("#{@scheme}://#{tmpHost}", @persistent, @connection_options)
          contentType = params[:contentType]

          begin
            headers = ''
            if params[:headers]
              params[:headers].each do |k, v|
              headers += "#{k}:#{v}\n" if k != 'Range'
              end
            end
            signature = sign(method, date, contentType, params[:resource], headers)
            response = @connection.request(params.merge(headers: {
              'Content-Type' => contentType,
              'Authorization' => 'OSS ' + @aliyun_accesskey_id + ':' + signature,
              'Date' => date
            }.merge!(params[:headers] || {}),
                                                        path: "#{@path}/#{params[:path]}",
                                                        query: params[:query]))
          rescue Excon::Errors::HTTPStatusError => error
            raise case error
                  when Excon::Errors::NotFound
                    Fog::Aliyun::Storage::NotFound.slurp(error)
                  else
                    error
                  end
          end

          response
        end

        # copmute signature
        def sign(method, date, contentType, resource = nil, headers = nil)
          contentmd5 = ''

          canonicalizedResource = if resource
                                    '/' + resource
                                  else
                                    '/'
                                  end

          canonicalizedOSSHeaders = headers || ''

          contentTypeStr = contentType || ''

          stringToSign = method + "\n" + contentmd5 + "\n" + contentTypeStr + "\n" + date + "\n" + canonicalizedOSSHeaders + canonicalizedResource

          digVer = OpenSSL::Digest.new('sha1')
          digest = OpenSSL::HMAC.digest(digVer, @aliyun_accesskey_secret, stringToSign)
          signature = Base64.encode64(digest)
          signature[-1] = ''

          signature
        end
      end

      class Mock
        def initialize(options = {})
          @aliyun_oss_endpoint = options[:aliyun_oss_endpoint]
          @aliyun_region_id = options[:aliyun_region_id]
          @aliyun_accesskey_id = options[:aliyun_accesskey_id]
          @aliyun_accesskey_secret = options[:aliyun_accesskey_secret]
          @aliyun_oss_bucket = options[:aliyun_oss_bucket]

          @connection_options = options[:connection_options] || {}
        end
      end
    end
  end
end
