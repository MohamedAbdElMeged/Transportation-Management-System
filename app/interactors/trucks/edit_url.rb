module Trucks
  class EditUrl
    include Interactor

    def call
      context.url = edit_url
    end

    private

    def edit_url
      params = HttpHelper.add_params(context.params)
      url = ENV['TRUCK_API_URL']
      url + params
    end
  end
end
