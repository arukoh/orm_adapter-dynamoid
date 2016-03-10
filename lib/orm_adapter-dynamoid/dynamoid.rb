require 'dynamoid'

module Dynamoid
  module Errors
    class DocumentNotFound < StandardError; end
  end
end

module Dynamoid
  module Document
    module ClassMethods
      include OrmAdapter::ToAdapter
    end

    class OrmAdapter < ::OrmAdapter::Base
      # get a list of column names for a given class
      def column_names
        klass.attributes.keys
      end

      # @see OrmAdapter::Base#get!
      def get!(id)
        klass.find_by_id(wrap_key(id)) || raise(Dynamoid::Document::DocumentNotFound)
      end

      # @see OrmAdapter::Base#get
      def get(id)
        klass.where(klass.hash_key => wrap_key(id)).first
      end

      # @see OrmAdapter::Base#find_first
      def find_first(options = {})
        conditions, order = extract_conditions!(options)
#        klass.limit(1).where(conditions_to_fields(conditions)).order_by(order).first
        klass.where(conditions_to_fields(conditions)).first
      end

      # @see OrmAdapter::Base#find_all
      def find_all(options = {})
        conditions, order, limit, offset = extract_conditions!(options)
#        klass.where(conditions_to_fields(conditions)).order_by(order).limit(limit).offset(offset)
        klass.where(conditions_to_fields(conditions))
      end

      # @see OrmAdapter::Base#create!
      def create!(attributes = {})
        klass.create!(attributes)
      end

      # @see OrmAdapter::Base#destroy
      def destroy(object)
        object.destroy if valid_object?(object)
      end

    protected

      def conditions_to_fields(conditions)
        conditions.inject({}) do |fields, (key, value)|
          if value.is_a?(Dynamoid::Document) && assoc_key = association_key(key)
            fields.merge(assoc_key => Set[value.id])
          else
            fields.merge(key => value)
          end
        end
      end

      def association_key(key)
        k = "#{key}_ids"
        column_names.find{|c| c == k || c == k.to_sym}
      end
    end
  end
end
