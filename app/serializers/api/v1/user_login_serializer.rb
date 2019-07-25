# frozen_string_literal: true

module Api
  module V1
    class UserLoginSerializer < ActiveModel::Serializer
      attributes :id, :firstname, :lastname, :email, :api_key
    end
  end
end
