require "uri"
require "net/http"
require 'json'

def request(address)
    url = URI(address)
    url = URI("https://jsonplaceholder.typicode.com/posts")
    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["Cookie"] = "__cfduid=df87f96a76cb2da0fcb5c3914fb71a3191594607495"

    response = https.request(request)
    JSON.parse response.read_body
    end
    
    body = request("https://jsonplaceholder.typicode.com/posts")
    body.each do |post|
    puts post['title']
end