module Ruboty
  module Handlers
    class TrelloQuote < Base
      on(%r{.*https?://trello.com/c/(?<id>[^/]+).*},
         description: 'quote trello card',
         name: :quote,
         all: true)

      def quote(message)
        Ruboty::TrelloQuote::Actions::Quote.new(message).call
      end
    end
  end
end
