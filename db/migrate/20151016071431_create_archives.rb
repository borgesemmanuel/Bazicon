class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|

      t.column :name, :string
      t.column :office_id, :integer #foreigner_key (office)
      t.column :person_id, :integer #foreigner_key (people)
      t.column :archive_extension, :string
      t.column :is_deleted, :bool, default: false
      t.column :is_private, :bool, default: false

      t.timestamps null: false
    end

    create_table :archive_tags do |t|
      t.column :tag_id, :integer #foreigner_key (tag)
      t.column :archive_id, :integer #foreigner_key (archive)
      t.timestamps null: false
    end

    create_table :tags do |t|
      t.column :name, :string
      t.timestamps null: false
    end
  end
end
