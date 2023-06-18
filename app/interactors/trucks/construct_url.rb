module Trucks
  class ConstructUrl
    include Interactor

    def call
      context.url = edit_url
    end

    private

    def edit_url
      url = ENV['TRUCK_API_URL']
      return url unless context.params

      params = HttpHelper.add_params(context.params)

      url + params
    end
  end
end
