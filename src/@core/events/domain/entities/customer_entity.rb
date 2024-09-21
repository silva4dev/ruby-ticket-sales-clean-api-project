# frozen_string_literal: true

require_relative '../../../common/domain/aggregate_root'
require_relative '../../../common/domain/value_objects/name_vo'

module Events
  module Domain
    module Entities
      class Customer < Common::Domain::AggregateRoot
        attr_accessor :id, :cpf, :name

        def initialize(id: nil, cpf:, name:)
          super()
          @id = id
          @cpf = cpf
          @name = Common::Domain::ValueObjects::Name.new(name)
        end

        def self.create(command)
          new(
            cpf: command[:cpf],
            name: Common::Domain::ValueObjects::Name.new(command[:name])
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
