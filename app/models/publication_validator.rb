class PublicationValidator < ActiveModel::Validator

  def validate(record)
    if ((record.published_at.present? && record.unpublished_at.present?) && (record.published_at >= record.unpublished_at))
      return false
    else
      return true
    end

  end

end
