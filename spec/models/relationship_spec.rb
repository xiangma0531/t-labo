require 'rails_helper'

RSpec.describe Relationship, type: :model do
  # インスタンス生成
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @relationship = FactoryBot.build(:relationship)
    @relationship.user_id = @user1.id
    @relationship.follow_id = @user2.id
  end

  # ユーザーフォローの登録に関するテストコード
  describe 'ユーザーフォローの登録' do
    
    # 正常系
    context '新規登録できる場合' do

      it 'すべての項目が入力されていれば登録できる' do
        expect(@relationship).to be_valid
      end
    end

    # 異常系
    context '新規登録できない場合' do
      
      it 'userが空の場合登録できない' do
        @relationship.user = nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include("Userを入力してください")
      end
      
      it 'followが空の場合登録できない' do
        @relationship.follow = nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include("Followを入力してください")
      end
      
    end
  end
end
