# -*- encoding: utf-8 -*-
# stub: pusher 1.3.3 ruby lib

Gem::Specification.new do |s|
  s.name = "pusher".freeze
  s.version = "1.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Pusher".freeze]
  s.date = "2019-07-02"
  s.description = "Wrapper for Pusher Channels REST api: : https://pusher.com/channels".freeze
  s.email = ["support@pusher.com".freeze]
  s.homepage = "http://github.com/pusher/pusher-http-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Pusher Channels API client".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<pusher-signature>.freeze, ["~> 0.1.8"])
      s.add_runtime_dependency(%q<httpclient>.freeze, ["~> 2.7"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_development_dependency(%q<em-http-request>.freeze, ["~> 1.1.0"])
      s.add_development_dependency(%q<addressable>.freeze, ["= 2.4.0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.4.2"])
      s.add_development_dependency(%q<rack>.freeze, ["~> 1.6.4"])
      s.add_development_dependency(%q<json>.freeze, ["~> 1.8.3"])
    else
      s.add_dependency(%q<multi_json>.freeze, ["~> 1.0"])
      s.add_dependency(%q<pusher-signature>.freeze, ["~> 0.1.8"])
      s.add_dependency(%q<httpclient>.freeze, ["~> 2.7"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_dependency(%q<em-http-request>.freeze, ["~> 1.1.0"])
      s.add_dependency(%q<addressable>.freeze, ["= 2.4.0"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.4.2"])
      s.add_dependency(%q<rack>.freeze, ["~> 1.6.4"])
      s.add_dependency(%q<json>.freeze, ["~> 1.8.3"])
    end
  else
    s.add_dependency(%q<multi_json>.freeze, ["~> 1.0"])
    s.add_dependency(%q<pusher-signature>.freeze, ["~> 0.1.8"])
    s.add_dependency(%q<httpclient>.freeze, ["~> 2.7"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<em-http-request>.freeze, ["~> 1.1.0"])
    s.add_dependency(%q<addressable>.freeze, ["= 2.4.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.4.2"])
    s.add_dependency(%q<rack>.freeze, ["~> 1.6.4"])
    s.add_dependency(%q<json>.freeze, ["~> 1.8.3"])
  end
end
