# frozen_string_literal: true

require_relative '../../../common/domain/aggregate_root'
require_relative '../../../common/domain/value_objects/uuid_vo'

module Events
  module Domain
    module Entities
      class EventSection < Common::Domain::AggregateRoot
        attr_accessor :name, :description, :is_published, :total_spots, :total_spots_reserved, :price

        def initialize(id: nil, name:, description:, is_published:, total_spots:, total_spots_reserved:, price:)
          super()
          @id = id.is_a?(String) ? Common::Domain::ValueObjects::Uuid.new(id) : id || Common::Domain::ValueObjects::Uuid.new
          @name = name
          @description = description || nil
          @is_published = is_published
          @total_spots = total_spots
          @total_spots_reserved = total_spots_reserved
          @price = price
        end

        def self.create(command)
          new(
            name: command[:name],
            description: command[:description] || nil,
            is_published: false,
            total_spots: command[:total_spots],
            total_spots_reserved: 0,
            price: command[:price]
          )
        end

        def to_hash
          {
            id: @id.value,
            name: @name,
            description: @description,
            is_published: @is_published,
            total_spots: @total_spots,
            total_spots_reserved: @total_spots_reserved,
            price: @price
          }
        end
      end
    end
  end
end
