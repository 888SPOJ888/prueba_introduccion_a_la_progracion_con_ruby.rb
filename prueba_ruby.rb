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
    request["app_id"] = '3cb74d10-8031-43c4-afa9-c3b4393ff4fa '
    request["app_key"] = 'ZJ2ZBVN4z4BhxoNPmILVaAh12jMiyCGBr8gMlPEw' 
    response = http.request(request)
    return JSON.parse(response.body)
end

body = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=ZJ2ZBVN4z4BhxoNPmILVaAh12jMiyCGBr8gMlPEw') 

new_array = body["photos"]
values = (new_array.map {|photos| [photos["img_src"]]})
values2 = (new_array.map {|photos| [photos["camera"]]})

def build_web_page(array)
    output = "\n<html>\n\t<head>\n\t</head>\n\t<body>\n\t\t<ul>\n"
    array.each do |photo|
        photo.each do |ele|
            output += "\t\t\t<li><img src=#{ele} /> </li>\n"
        end
    end
    output += "\t\t</ul>\n\t</body>\n</html>"
    File.write('curiosity.html', output)
    
end
build_web_page(values)

def photos_count(count)
    new_hash = {}
    final_array = []
    count.each do |camera|
        camera.each do |ele|
            ele.each do |k, v|
                if k == "full_name"
                    new_hash[k] = v
                    final_array += new_hash.values
                end
            end
        end
    end