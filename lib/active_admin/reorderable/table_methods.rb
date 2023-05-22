module ActiveAdmin
  module Reorderable
    module TableMethods

      def reorder_column(**kwargs)
        column '', :class => 'reorder-handle-col' do |resource|
          reorder_handle_for(resource, **kwargs)
        end
      end

      private

      def reorder_handle_for(resource, **kwargs)
        aa_resource = active_admin_namespace.resource_for(resource.class)
        url = aa_resource.route_member_action_path(:reorder, resource)

        offset = kwargs[:offset] || (collection.limit_value * (collection.current_page - 1))

        span(
          reorder_handle_content,
          :class => 'reorder-handle',
          'data-reorder-url' => url,
          'data-reorder-id' => resource.id,
          'data-reorder-offset' => offset
        )
      end

      def reorder_handle_content
        '&equiv;&equiv;'.html_safe
      end

    end

    ::ActiveAdmin::Views::TableFor.send(:include, TableMethods)
  end
end
