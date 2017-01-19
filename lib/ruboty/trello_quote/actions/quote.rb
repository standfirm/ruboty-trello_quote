require 'trello'

module Ruboty
  module TrelloQuote
    module Actions
      class Quote
        attr_reader :message

        def initialize(message)
          @message = message

          Trello.configure do |config|
            config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
            config.member_token = ENV['TRELLO_MEMBER_TOKEN']
          end
        end

        def call
          return if skip?
          message.reply "* #{name}\n#{desc}"
        end

        private

        def name
          card.name
        end

        def desc
          card.desc
        end

        def card
          @card ||= Trello::Card.find(card_id)
        end

        def card_id
          message[:id].to_s.strip
        end

        def skip?
          regexp = ENV['TRELLO_IGNORE_USER']
          if regexp
            message.from_name =~ /#{regexp}/
          end
        end
      end
    end
  end
end
