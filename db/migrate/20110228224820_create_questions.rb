# -*- encoding : utf-8 -*-
class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
