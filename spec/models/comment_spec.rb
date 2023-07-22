require 'rails_helper'

RSpec.describe Comment, type: :model do
    # インスタンス生成
    before do
      @comment = FactoryBot.build(:comment)
    end
  
    # コメントの投稿に関するテストコード
    describe 'コメントの投稿' do
      
      # 正常系
      context '新規登録できる場合' do
  
        it 'すべての項目が入力されていれば登録できる' do
          expect(@comment).to be_valid
        end
      end
  
      # 異常系
      context '新規登録できない場合' do
        
        it 'textが空の場合登録できない' do
          @comment.text = ''
          @comment.valid?
          expect(@comment.errors.full_messages).to include("コメントを入力してください")
        end
        
        it 'userが空の場合登録できない' do
          @comment.user = nil
          @comment.valid?
          expect(@comment.errors.full_messages).to include("Userを入力してください")
        end
        
        it 'sourceが空の場合登録できない' do
          @comment.source = nil
          @comment.valid?
          expect(@comment.errors.full_messages).to include("Sourceを入力してください")
        end
        
      end
    end
end
