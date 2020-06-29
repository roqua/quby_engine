# frozen_string_literal: true

module Quby
  module Questionnaires
    module DSL
      module Helpers
        def image_tag(*args)
          options = args.extract_options!

          ActionController::Base.helpers.image_tag(
            *args, options.reverse_merge(alt: image_alt(args.first))
          )
        end

        # Copied from ActionController::Base.helpers.image_alt, because it will be removed from Rails 6.0, but we want
        # to keep using this functionality
        def image_alt(source)
          File.basename(source, ".*").sub(/-[[:xdigit:]]{32,64}\z/, "").tr("-_", " ").capitalize
        end

        def check_question_keys_uniqueness(key, options, questionnaire)
          keys = QuestionBuilder.build(key, options).claimed_keys
          if keys.any? { |k| questionnaire.key_in_use? k }
            fail "#{questionnaire.key}:#{key}: A question or option with input key #{key} is already defined."
          end
        end

        def video_tag(*urls, poster: nil, autoplay: false, loop: false)
          # assume the file extension is the video format
          # otherwise, the host's declared mime type is used to figure out compatibility
          # which is usually wrong
          sources = urls.map { |url| [url, url.match(/[^\.]*\z/)&.[](0).downcase] }
          sources.each { |_url, ext| raise 'unknown video url file extension' unless %w[mp4 webm].include?(ext) }

          ActionController::Base.helpers.tag.video\
            width: '100%',
            preload: 'none',
            poster: poster,
            loop: loop,
            autoplay: autoplay,
            muted: autoplay,
            controls: '' do |tag|
              sources.map { |url, ext| tag.source src: url, type: "video/#{ext}" }
                .append(I18n.t('video_not_supported'))
                .yield_self(&tag.method(:safe_join))
          end
        end
      end
    end
  end
end
