# frozen_string_literal: true

require_relative '../../../common/domain/aggregate_root'
require_relative '../../../common/domain/value_objects/cpf_vo'
require_relative '../../../common/domain/value_objects/uuid_vo'

module Events
  module Domain
    module Entities
      class Customer < Common::Domain::AggregateRoot
        attr_reader :cpf, :name

        def initialize(cpf:, name:, id: nil)
          super()
          @id = id.is_a?(String) ? Common::Domain::ValueObjects::Uuid.new(id) : id || Common::Domain::ValueObjects::Uuid.new
          @cpf = Common::Domain::ValueObjects::Cpf.new(cpf)
          @name = name
        end

        def self.create(command)
          new(
            cpf: command[:cpf],
            name: command[:name]
          )
        end

        def to_hash
          {
            id: @id,
            cpf: @cpf,
            name: @name
          }
        end
      end
    end
  end
end
