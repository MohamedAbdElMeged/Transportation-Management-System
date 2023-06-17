module Trucks
  class SetParams
    include Interactor
    def call
      context.params = set_params
    end

    private

    def set_params
      {
        page: REDIS.get('next_page') || 1
      }
    end
  end
end
