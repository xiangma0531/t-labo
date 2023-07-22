require 'rails_helper'

RSpec.describe Like, type: :model do
  # インスタンス生成
  before do
    @like = FactoryBot.build(:like)
  end

  # お気に入りの登録に関するテストコード
  describe 'お気に入りの登録' do
    
    # 正常系
    context '新規登録できる場合' do

      it 'すべての項目が入力されていれば登録できる' do
        expect(@like).to be_valid
      end
    end

    # 異常系
    context '新規登録できない場合' do
      
      it 'userが空の場合登録できない' do
        @like.user = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("Userを入力してください")
      end
      
      it 'sourceが空の場合登録できない' do
        @like.source = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("Sourceを入力してください")
      end
      
    end
  end
end
