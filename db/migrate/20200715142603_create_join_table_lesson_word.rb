class CreateJoinTableLessonWord < ActiveRecord::Migration[6.0]
  def change
    create_join_table :lessons, :words do |t|
       t.index [:lesson_id, :word_id]
       t.index [:word_id, :lesson_id]
    end
  end
end
