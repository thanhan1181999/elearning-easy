require 'fog/core/model'

module Fog
  module DNS
    class Dnsimple
      class Record < Fog::Model
        identity :id

        attribute :zone_id,     aliases: "domain_id"
        attribute :name
        attribute :value,       aliases: "content"
        attribute :ttl
        attribute :priority
        attribute :type
        attribute :created_at
        attribute :updated_at

        def initialize(attributes = {})
          super
        end

        def destroy
          service.delete_record(zone.id, identity)
          true
        end

        def zone
          @zone
        end

        def save
          requires :name, :type, :value
          options = {}
          options[:ttl] = ttl if ttl

          # decide whether its a new record or update of an existing
          if id.nil?
            data = service.create_record(zone.id, name, type, value, options)
          else
            options[:name] = name if name
            options[:content] = value if value
            options[:type] = type if type
            data = service.update_record(zone.id, id, options)
          end

          merge_attributes(data.body["data"])
          true
        end

        private

        def zone=(new_zone)
          @zone = new_zone
        end
      end
    end
  end
end
