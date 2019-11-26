# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

module Elasticsearch
  module API
    module Nodes
      module Actions
        # Returns statistical information about nodes in the cluster.

        #
        # @option arguments [List] :node_id A comma-separated list of node IDs or names to limit the returned information; use `_local` to return information from the node you're connecting to, leave empty to get information from all nodes

        #
        # @see https://www.elastic.co/guide/en/elasticsearch/reference/master/cluster-nodes-stats.html
        #
        def stats(arguments = {})
          arguments = arguments.clone

          _node_id = arguments.delete(:node_id)

          method = HTTP_GET
          path   = if _node_id && _metric && _index_metric
                     "_nodes/#{Utils.__listify(_node_id)}/stats/#{Utils.__listify(_metric)}/#{Utils.__listify(_index_metric)}"
                   elsif _metric && _index_metric
                     "_nodes/stats/#{Utils.__listify(_metric)}/#{Utils.__listify(_index_metric)}"
                   elsif _node_id && _metric
                     "_nodes/#{Utils.__listify(_node_id)}/stats/#{Utils.__listify(_metric)}"
                   elsif _node_id
                     "_nodes/#{Utils.__listify(_node_id)}/stats"
                   elsif _metric
                     "_nodes/stats/#{Utils.__listify(_metric)}"
                   else
                     "_nodes/stats"
  end
          params = Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)
          body   = nil

          perform_request(method, path, params, body).body
        end

        # Register this action with its valid params when the module is loaded.
        #
        # @since 6.2.0
        ParamsRegistry.register(:stats, [
          :completion_fields,
          :fielddata_fields,
          :fields,
          :groups,
          :level,
          :types,
          :timeout,
          :include_segment_file_sizes
        ].freeze)
  end
      end
end
end
