module Quby
  module Questionnaires
    module Repos
      class CachingRepo < Base
        attr_reader :repo
        attr_reader :cache

        def initialize(repo, preload: false)
          @repo  = repo
          @cache = {}

          if preload
            all
          end
        end

        def keys
          repo.keys
        end

        def find(key)
          return cache[key] if fresh?(key)
          cache[key] = repo.find(key)
          cache[key]
        end

        def exists?(key)
          repo.exists?(key)
        end

        def timestamp(key)
          repo.timestamp(key)
        end

        def create!(key, definition)
          repo.create!(key, definition)
        end

        def update!(key, definition)
          repo.update!(key, definition)
        end

        private

        def store!(key, definition)
          # bypassed by overriding create! and update!
          # we can't call store! on our subrepo, since it's not a public method
          fail NotImplementedError
        end

        def fresh?(key)
          return false unless cache[key].present?
          cache[key].timestamp.to_i == timestamp(key).to_i
        end
      end
    end
  end
end
