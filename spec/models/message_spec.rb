require 'rails_helper'

RSpec.describe Message, type: :model do
  # インスタンス生成
  before do
    @message = FactoryBot.build(:message)
  end

  # messageの送信に関するテストコード
  describe 'messageの送信' do
    
    # 正常系
    context '新規登録できる場合' do

      it 'すべての項目が入力されていれば登録できる' do
        expect(@message).to be_valid
      end
    end

    # 異常系
    context '新規登録できない場合' do
      
      it 'messageが空の場合登録できない' do
        @message.message = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Messageを入力してください")
      end
      
      it 'userが空の場合登録できない' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Userを入力してください")
      end
      
      it 'roomが空の場合登録できない' do
        @message.room = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Roomを入力してください")
      end
      
    end
  end
end
