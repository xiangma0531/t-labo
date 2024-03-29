require 'rails_helper'

RSpec.describe Room, type: :model do
  # インスタンス生成
  before do
    @room = FactoryBot.build(:room)
  end

  # チャットルームの作成に関するテストコード
  describe 'チャットルームの作成' do
    
    # 正常系
    context '新規登録できる場合' do

      it '特に何も入力されていなくても登録できる' do
        expect(@room).to be_valid
      end
    end

  end  
end
