# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

module Elasticsearch
  module API
    module Indices
      module Actions
        # Allow to shrink an existing index into a new index with fewer primary shards.

        #
        # @option arguments [String] :index The name of the source index to shrink
        # @option arguments [String] :target The name of the target index to shrink into
        # @option arguments [Hash] :body The configuration for the target index (`settings` and `aliases`)

        #
        # @see https://www.elastic.co/guide/en/elasticsearch/reference/master/indices-shrink-index.html
        #
        def shrink(arguments = {})
          raise ArgumentError, "Required argument 'index' missing" unless arguments[:index]
          raise ArgumentError, "Required argument 'target' missing" unless arguments[:target]

          arguments = arguments.clone

          _index = arguments.delete(:index)

          _target = arguments.delete(:target)

          method = HTTP_PUT
          path   = "#{Utils.__listify(_index)}/_shrink/#{Utils.__listify(_target)}"
          params = Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)
          body   = arguments[:body]

          perform_request(method, path, params, body).body
        end

        # Register this action with its valid params when the module is loaded.
        #
        # @since 6.2.0
        ParamsRegistry.register(:shrink, [
          :copy_settings,
          :timeout,
          :master_timeout,
          :wait_for_active_shards
        ].freeze)
  end
      end
end
end
