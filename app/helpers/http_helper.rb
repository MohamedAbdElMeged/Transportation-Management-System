require 'net/http'
require 'uri'
module HttpHelper
  module_function

  def send_get_request(url, headers)
    uri = URI.parse(url)
    request = Net::HTTP::Get.new(uri)
    headers.each do |k, v|
      request[k] = v
    end
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
  end

  def add_params(params)
    params_string = '?'
    params.each do |k, v|
      params_string.concat("#{k}=#{v}&")
    end
    params_string
  end
end
