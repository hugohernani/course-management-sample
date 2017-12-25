class CreateCourseRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :course_relations do |t|
      t.references :course, foreign_key: true, index: true
      t.references :entity, polymorphic: true, index: true

      t.timestamps
    end
  end
end
