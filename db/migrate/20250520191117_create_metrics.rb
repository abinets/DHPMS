class CreateMetrics < ActiveRecord::Migration[8.0]
  def change
    create_table :metrics do |t|
      t.integer :value
      t.datetime :time

      t.timestamps
    end
  end
end
