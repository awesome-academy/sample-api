module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        # formatter :json, Grape::Formmater::ActiveModelSerializers
      end
    end
  end
end
