# -*- encoding : utf-8 -*-
class CreateVisualizations < ActiveRecord::Migration
  def self.up
    create_table :visualizations do |t|
      t.integer :question_id
      t.string :ip_address
      t.string :browser_agent

      t.timestamps
    end
  end

  def self.down
    drop_table :visualizations
  end
end
