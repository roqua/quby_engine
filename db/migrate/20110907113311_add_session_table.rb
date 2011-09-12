class AddSessionTable < ActiveRecord::Migration
  def self.up
    create_table "sessions", :force => true do |t|
      t.string   "session_id", :null => false
      t.text     "data"
      t.datetime "updated_at"
      t.datetime "created_at"
    end

    add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
    add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"
  end

  def self.down
  end
end
