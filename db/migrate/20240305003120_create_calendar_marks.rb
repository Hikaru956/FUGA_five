class CreateCalendarMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_marks do |t|
      t.integer :shop_id
      t.integer :staff_id,  default: nil
      t.date    :target_date
      t.integer :mark_type, default: CalendarMark::TYPE_NONE
      t.timestamps
    end
    add_index :calendar_marks, :shop_id
    add_index :calendar_marks, [:shop_id, :staff_id]
    add_index :calendar_marks, :target_date
  end
end
