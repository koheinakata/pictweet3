class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :name
      t.text :new_text
      t.text :image
      t.timestamps
    end
  end
end

# マイグレーションファイル・・・テーブルの設計図

