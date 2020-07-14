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
info = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&', 'api_key=ZJ2ZBVN4z4BhxoNPmILVaAh12jMiyCGBr8gMlPEw')
def build_web_page(info)
    output = "<html>\n/<head>\n</head>\n<body>\n<ul>"
    info.each do |img|
        output += "\t<li><img src=#{img["img_src"]}\"></li>\n"
    end
    output += "</ul>\n</body>\n</html>"
    File.write('NASA.html', output)
    
end
create_web_page(data)