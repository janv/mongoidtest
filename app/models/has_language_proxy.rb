module HasLanguageProxy
  def embeds_many_multilang(relation_name, relation_options={})
    proxy_class = make_proxy_class(relation_name, :embeds_many, relation_options)
    embeds_one relation_name, :class_name => proxy_class.name
    after_initialize do |proxy_owner|
      puts "Hallo"
      proxy_owner.send(:"#{relation_name}=", proxy_class.new) if proxy_owner.send(:"#{relation_name}").nil?
    end
  end

  def embeds_one_multilang(relation_name, relation_options={})
    proxy_class = make_proxy_class(relation_name, :embeds_one, relation_options)
    embeds_one relation_name, :class_name => proxy_class.name
    after_initialize do |proxy_owner|
      puts "Hallo"
      proxy_owner.send(:"#{relation_name}=", proxy_class.new) if proxy_owner.send(:"#{relation_name}").nil?
    end
  end

private

  def make_proxy_class(relation_name, relation_type, relation_options)
    proxy_class = Class.new(LanguageProxy) do
      # TODO embedded_in statement für die Proxy Class richtig
      # TODO embedded_in statement für die Zielklasse richtig (d.h., das ":as =>" in der ProxyClass muss passend sein)
      
      cattr_accessor :association_class_name, :association_options
    end

    proxy_class.association_class_name = relation_name.to_s.classify
    proxy_class.association_options    = relation_options
    proxy_class.association_type       = relation_type

    proxy_class.create_relations
    
    Object.const_set(proxy_class_name(relation_name, relation_type), proxy_class)
    return proxy_class
  end
  
  def proxy_class_name(relation_name, relation_type)
    relation_type_part = case relation_type
      when :embeds_many
        "EmbedsMany"
      when :embeds_one
        "EmbedsOne"
      else
        raise "Unknown relation type #{relation_type}"
      end
    
    "LanguageProxy#{relation_name.to_s.classify}#{relation_type_part}"
  end
end
