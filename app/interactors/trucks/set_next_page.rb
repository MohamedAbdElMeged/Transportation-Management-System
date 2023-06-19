module Trucks
  class SetNextPage
    include Interactor
    def call
      set_next_page
    end

    private

    def set_next_page
      next_page = context.response_headers&.[]('current-page').to_i + 1
      if context.response_body_count < 25
        context.last_page = true
      else
        REDIS.set('next_page', next_page)
      end
    end
  end
end
