module Github
  class Webhook
    class RepositoryHandler
      class CreateAction
        def self.execute(handler)
          RepositoryRepository.new.create(name: handler.full_name)
        end
      end

      class DeleteAction
        def self.execute(handler)
          RepositoryRepository.new.find_by(name: handler.full_name).destroy
        end
      end

      class NonExistingAction
        def self.execute(_handler)
          # do nothing
        end
      end

      TRANSITION_MAP = {
        "created" => CreateAction,
        "deleted" => DeleteAction
      }.freeze

      def initialize(payload)
        @payload = payload
      end

      def save
        TRANSITION_MAP.fetch(action, NonExistingAction).execute(self)
      end

      def action
        payload[:action]
      end

      def full_name
        payload[:repository][:full_name]
      end

      private

      attr_reader :payload
    end
  end
end
