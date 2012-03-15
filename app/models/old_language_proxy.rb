class LanguageProxy
  AVAILABLE_LANGUAGES = %w(de en fr)
  
  field :available_languages, :default => {Set.new}
  
  def self.association_class_name
    # Implement?
  end
  
  def self.association_options
    # Implement?
  end

  AVAILABLE_LANGUAGES.each do |locale|
    options = {:class_name => association_class_name}.merge(association_options)
    embeds_many "lang_#{locale}", options
  end
  
  def get(locale)
    if available_languages.include?(locale)
      self.send("lang_#{locale}")
    else
      nil
    end
  end
  
  def set(locale, value)
    self.send("lang_#{locale}=", value) if available_languages.include?(locale)
  end  
  
end