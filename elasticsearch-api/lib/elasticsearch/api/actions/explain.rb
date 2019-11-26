# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

module Elasticsearch
  module API
    module Actions
      # Returns information about why a specific matches (or doesn't match) a query.

      #
      # @option arguments [String] :id The document ID
      # @option arguments [String] :index The name of the index
      # @option arguments [Hash] :body The query definition using the Query DSL

      #
      # @see https://www.elastic.co/guide/en/elasticsearch/reference/master/search-explain.html
      #
      def explain(arguments = {})
        raise ArgumentError, "Required argument 'index' missing" unless arguments[:index]
        raise ArgumentError, "Required argument 'id' missing" unless arguments[:id]

        arguments = arguments.clone

        _id = arguments.delete(:id)

        _index = arguments.delete(:index)

        method = HTTP_GET
        path   = "#{Utils.__listify(_index)}/_explain/#{Utils.__listify(_id)}"
        params = Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)
        body   = arguments[:body]

        perform_request(method, path, params, body).body
      end

      # Register this action with its valid params when the module is loaded.
      #
      # @since 6.2.0
      ParamsRegistry.register(:explain, [
        :analyze_wildcard,
        :analyzer,
        :default_operator,
        :df,
        :stored_fields,
        :lenient,
        :preference,
        :q,
        :routing,
        :_source,
        :_source_excludes,
        :_source_includes
      ].freeze)
    end
  end
end
