require 'uri' 
require 'net/http'
require 'openssl'
require 'json'

def request(url_requested) 
    url = URI(url_requested)
    http = Net::HTTP.new(url.host, url.port) 
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    request["app_id"] = ''
    request["app_key"] = '' 
    response = http.request(request)
    return JSON.parse(response.body)
end

data = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=ZJ2ZBVN4z4BhxoNPmILVaAh12jMiyCGBr8gMlPEw') 


def create_web_page(array)
    output = "<html>\n/<head>\n</head>\n<body>\n<ul>"
    array.each do |photo|
        output += "\t<li><img src=\"#{photo}\"></li>\n"
    end
    output += "</ul>\n</body>\n</html>"
    File.write('curiosity.html', output)
    
end
create_web_page(data)