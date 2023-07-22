require 'rails_helper'

RSpec.describe Source, type: :model do
  # インスタンス生成
  before do
    @source = FactoryBot.build(:source)
  end

  # 記事の投稿に関するテストコード
  describe '記事の投稿' do
    
    # 正常系
    context '新規登録できる場合' do

      it 'すべての項目が入力されていれば登録できる' do
        expect(@source).to be_valid
      end

      it 'title、grade_id、subject_id、contentが入力されていれば登録できる' do
        @source.course_id = nil
        @source.image = nil
        expect(@source).to be_valid
      end

      it 'title、grade_id、subject_idの入力とimageの添付がされていれば登録できる' do
        @source.course_id = nil
        @source.content = ''
        expect(@source).to be_valid
      end

      it 'titleとcontentの入力とimageの添付ができていれば登録できる' do
        expect(@source).to be_valid
      end

    end

    # 異常系
    context '新規登録できない場合' do

      it 'title、grade_id、subject_idが未入力かつimageが添付されていない場合登録できない' do
        @source.title = ''
        @source.grade_id = nil
        @source.subject_id = nil
        @source.content = ''
        @source.image = nil
        @source.valid?
        expect(@source.errors.full_messages).to include("タイトルを入力してください", "概要を入力してください")
      end
      
      it 'titleが空の場合登録できない' do
        @source.title = ''
        @source.valid?
        expect(@source.errors.full_messages).to include("タイトルを入力してください")
      end
      
      it 'grade_idが空の場合登録できない' do
        @source.grade_id = nil
        @source.valid?
        expect(@source.errors.full_messages).to include("校種を入力してください")
      end
      
      it 'subject_idが空の場合登録できない' do
        @source.subject_id = nil
        @source.valid?
        expect(@source.errors.full_messages).to include("教科を入力してください")
      end

      it 'contentとimageがともに空の場合登録できない' do
        @source.content = ''
        @source.image = nil
        @source.valid?
        expect(@source.errors.full_messages).to include("概要を入力してください")
      end

      it 'userが紐づいていないと登録できない' do
        @source.user = nil
        @source.valid?
        expect(@source.errors.full_messages).to include("Userを入力してください")
      end
      
    end
  end
end
