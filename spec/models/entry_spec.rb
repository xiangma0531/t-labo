require 'rails_helper'

RSpec.describe Entry, type: :model do
  # インスタンス生成
  before do
    @entry = FactoryBot.build(:entry)
  end

  # Entryの登録に関するテストコード
  describe 'Entryの登録' do
    
    # 正常系
    context '新規登録できる場合' do

      it 'すべての項目が入力されていれば登録できる' do
        expect(@entry).to be_valid
      end
    end

    # 異常系
    context '新規登録できない場合' do
      
      it 'userが空の場合登録できない' do
        @entry.user = nil
        @entry.valid?
        expect(@entry.errors.full_messages).to include("Userを入力してください")
      end
      
      it 'roomが空の場合登録できない' do
        @entry.room = nil
        @entry.valid?
        expect(@entry.errors.full_messages).to include("Roomを入力してください")
      end
      
    end
  end
end
