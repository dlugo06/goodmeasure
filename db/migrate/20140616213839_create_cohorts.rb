class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string :name
      t.text :description
      t.references :school, index: true

      t.timestamps
    end
  end
end
