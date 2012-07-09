actions :set, :delete

# Requiring causes validation to fail if the key is specified via the resource name
# attribute :key, :kind_of => String, :name_attribute => true, :required => true
attribute :key, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String, :required => true
attribute :attr_val
attribute :attr_type, :kind_of => String, :default => 'string', :equal_to => ['int', 'bool', 'float', 'string', 'list']
attribute :list_type, :kind_of => String, :default => 'string', :equal_to => ['int', 'bool', 'float', 'string']
attribute :recursive, :kind_of => [TrueClass, FalseClass], :default => false

