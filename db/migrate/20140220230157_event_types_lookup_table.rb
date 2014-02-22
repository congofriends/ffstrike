class EventTypesLookupTable < ActiveRecord::Migration
  def self.up
    create_table :event_types do |t|
      t.string :name
    end

    change_table :events do |t|
      t.remove :event_type
      t.integer :event_type_id
    end

    EventType.reset_column_information
    types = %w(Rally Public\ speak\ out Movie\ screening Public\ forum Meet\ with\ decision\ maker Planning\ meeting Own\ event)
    types.each { |type| EventType.create(name: type) }
  end

  def self.down
    drop_table :event_types

    change_table :events do |t|
      t.remove :event_type_id
      t.string :event_type
    end
  end
end
