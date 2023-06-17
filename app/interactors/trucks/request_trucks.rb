module Trucks
  class RequestTrucks
    include Interactor
    def call
      make_request
    end

    private

    def make_request
      response = HttpHelper.send_get_request(context.url, context.request_headers)
      if response.is_a? Net::HTTPSuccess
        context.response_body = JSON.parse(response.body)
        context.response_body_count = context.response_body.size

        context.response_headers = response.each_header.to_h
      else
        context.fail!(message: "Failed to request trucks #{response.message}")
      end
    end
  end
end
