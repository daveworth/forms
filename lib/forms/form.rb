require 'uber/inheritable_attr'

module Forms
  class Form
    extend Uber::InheritableAttribute

    attr_reader :attributes
    attr_reader :object

    # The internal middleware stack for this form object
    inheritable_attr :middleware
    self.middleware = Forms::Middleware.new

    # The default method it uses to persist the object
    inheritable_attr :persist_method
    self.persist_method = :save

    # Context methods available to middlewares
    inheritable_attr :context_options
    self.context_options = []

    def initialize(options = {})
      @attributes = options.fetch(:attributes, {})
      @object     = options.fetch(:object, DefaultObject.new)
    end

    def self.context(*contexts)
      self.context_options.concat(contexts)
    end
  end
end