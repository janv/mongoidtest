class LanguageProxy
  include Mongoid::Document
  AVAILABLE_LANGUAGES = %w(de en fr)
  
  field :available_languages, :default => {'de' => true, 'en' => true}
  
  cattr_accessor :association_class_name, :association_options, :association_type
  
  def self.relation_statement(*args)
    self.send(association_type, *args)
  end
  
  def self.relation_options
    {:class_name => association_class_name}.merge(association_options)
  end
  
  def self.create_relations
    AVAILABLE_LANGUAGES.each do |locale|
      relation_statement "lang_#{locale}", relation_options
    end
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