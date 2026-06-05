class CommentHandler
  class CommentsLengthError < StandardError
    MAX_COMMENT_LENGTH = 100
    MIN_COMMENT_LENGTH = 3

    def self.validate_comment_length(body)
      if body.length > MAX_COMMENT_LENGTH
        raise CommentsLengthError, I18n.t('errors.comment_too_long', max_length: MAX_COMMENT_LENGTH)
      elsif body.length < MIN_COMMENT_LENGTH
        raise CommentsLengthError, I18n.t('errors.comment_too_short', min_length: MIN_COMMENT_LENGTH)
      end
    end
  end
end
