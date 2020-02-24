class PublicationValidator < ActiveModel::Validator

  def validate(record)
    #record.errors.add(:happened_at, 'published_at must be a valid datetime  ') if ((DateTime.parse(record.published_at)   rescue ArgumentError) == ArgumentError)
    #record.errors.add(:happened_at, 'unpublished_at must be a valid datetime') if ((DateTime.parse(record.unpublished_at) rescue ArgumentError) == ArgumentError)
    if ((record.published_at.present? && record.unpublished_at.present?) && (record.published_at >= record.unpublished_at))
      return false
    else
      return true
    end

  end

end
