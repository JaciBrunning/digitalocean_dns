require 'droplet_kit'
require 'open-uri'

API_KEY = ENV['API_KEY'] || abort('No API Key! Set with ENV Var API_KEY')
DOMAIN = ENV['DOMAIN'] || abort('No Domain! Set with ENV Var DOMAIN')
SUBDOMAIN = ENV['SUBDOMAIN'] || abort('No Subdomain! Set with ENV Var SUBDOMAIN')
TTL = ENV['TTL'] || 3600
RATE = ENV['RATE'] || 3600 


while true
  @ip = ENV['TARGET_IP'] || open('https://ipinfo.io/ip').read.strip
  puts "Updating #{SUBDOMAIN}.#{DOMAIN} with #{@ip} @ ttl=#{TTL}"

  @client = DropletKit::Client.new(access_token: API_KEY)
  @record = @client.domain_records.all(for_domain: DOMAIN).find { |x| x.type == 'A' && x.name == SUBDOMAIN }

  if @record.nil?
    puts "Nil Record. Creating a new one..."
    @record = DropletKit::DomainRecord.new(
      type: 'A',
      name: SUBDOMAIN,
      data: @ip,
      ttl: TTL.to_i
    )
    @client.domain_records.create(@record, for_domain: DOMAIN)
  else 
    puts "Record Found... ID: #{@record.id}"
  end

  @record = @client.domain_records.all(for_domain: DOMAIN).find { |x| x.type == 'A' && x.name == SUBDOMAIN }

  puts "Updating Record ID: #{@record.id}"
  @record.data = @ip
  @client.domain_records.update(@record, for_domain: DOMAIN, id: @record.id)

  puts "DONE!"

  sleep RATE.to_i
end