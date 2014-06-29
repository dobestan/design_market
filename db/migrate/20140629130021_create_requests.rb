class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :user

      # Info from user
      t.string :usage #디자인 용도
      t.integer :design_type #디자인 타입 : 로고, 포스터, 앨범커버, 간판, 패키지, 명함, 표지
      # Documentation Needed

      t.string :description #디자인 상세설명
      t.string :token

      t.timestamps
    end
  end
end
