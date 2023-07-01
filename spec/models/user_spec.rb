require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    # 正常系
    context '新規登録できる場合' do
      it 'name、email、password、password_confirmation、grade_id、subject_id、course_id、introductionがあれば登録できる' do
        
      end

      it 'name、email、password、password_confirmationがあれば、grade_id、subject_id、course_id、introductionが未入力でも登録できる' do

      end
    end

    # 異常系
    context '新規登録できない場合' do
      it 'nameが空では登録できない' do

      end

      it 'emailが空では登録できない' do
        
      end

      it 'passwordが空では登録できない' do
        
      end

      it 'passwordとpassword_confirmationが一致していなければ登録できない' do
        
      end
    end
  end
end
