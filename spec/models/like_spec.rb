require 'rails_helper'

RSpec.describe Like, type: :model do
  # インスタンス生成
  before do
    @like = FactoryBot.build(:like)
  end

  # コメントの投稿に関するテストコード
  describe 'コメントの投稿' do
    
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
        binding.pry
        expect(@like.errors.full_messages).to include("")
      end
      
      it 'sourceが空の場合登録できない' do
        @like.source = nil
        @like.valid?
        binding.pry
        expect(@like.errors.full_messages).to include("")
      end
      
    end
  end
end
