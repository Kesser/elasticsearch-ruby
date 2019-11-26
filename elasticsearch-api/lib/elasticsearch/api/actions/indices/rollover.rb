# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

module Elasticsearch
  module API
    module Indices
      module Actions
        # Updates an alias to point to a new index when the existing index
        # is considered to be too large or too old.

        #
        # @option arguments [String] :alias The name of the alias to rollover
        # @option arguments [Hash] :body The conditions that needs to be met for executing rollover

        #
        # @see https://www.elastic.co/guide/en/elasticsearch/reference/master/indices-rollover-index.html
        #
        def rollover(arguments = {})
          raise ArgumentError, "Required argument 'alias' missing" unless arguments[:alias]

          arguments = arguments.clone

          _alias = arguments.delete(:alias)

          method = HTTP_POST
          path   = if _alias && _new_index
                     "#{Utils.__listify(_alias)}/_rollover/#{Utils.__listify(_new_index)}"
                   else
                     "#{Utils.__listify(_alias)}/_rollover"
  end
          params = Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)
          body   = arguments[:body]

          perform_request(method, path, params, body).body
        end

        # Register this action with its valid params when the module is loaded.
        #
        # @since 6.2.0
        ParamsRegistry.register(:rollover, [
          :include_type_name,
          :timeout,
          :dry_run,
          :master_timeout,
          :wait_for_active_shards
        ].freeze)
  end
      end
end
end
