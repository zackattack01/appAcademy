# require_relative "../../app/models/shortened_url"
# require 'rake'
task :prune_urls => :environment do
  ShortenedUrl.prune
end
