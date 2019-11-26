# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

module Elasticsearch
  module API
    module Cat
      module Actions
        # Shows information about currently configured aliases to indices including filter and routing infos.

        #
        # @option arguments [List] :name A comma-separated list of alias names to return

        #
        # @see https://www.elastic.co/guide/en/elasticsearch/reference/master/cat-alias.html
        #
        def aliases(arguments = {})
          arguments = arguments.clone

          _name = arguments.delete(:name)

          method = HTTP_GET
          path   = if _name
                     "_cat/aliases/#{Utils.__listify(_name)}"
                   else
                     "_cat/aliases"
  end
          params = Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)
          body   = nil

          perform_request(method, path, params, body).body
        end

        # Register this action with its valid params when the module is loaded.
        #
        # @since 6.2.0
        ParamsRegistry.register(:aliases, [
          :format,
          :local,
          :h,
          :help,
          :s,
          :v
        ].freeze)
  end
      end
end
end
