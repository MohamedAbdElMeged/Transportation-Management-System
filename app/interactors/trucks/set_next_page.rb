module Trucks
  class SetNextPage
    include Interactor
    def call
      return if context.response_body_count < 25

      set_next_page
    end

    private

    def set_next_page
      next_page = context.response_headers&.[]('current-page').to_i + 1
      REDIS.set('next_page', next_page)
    end
  end
end
