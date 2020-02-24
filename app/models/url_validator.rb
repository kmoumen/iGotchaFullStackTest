class UrlValidator < ActiveModel::Validator

  def validate(record)
    uri = URI.parse(record.url)
    if uri.is_a?(URI::HTTP) && !uri.host.nil?
      return true
    else
      record.errors.add :base, "Invalid url"
      return false
    end
  end

end
