require 'rails_helper'

RSpec.describe "フォロー", type: :system do
  before do
    @source1 = FactoryBot.create(:source)
    @source2 = FactoryBot.create(:source)
  end

  context 'フォローができるとき' do
    it 'ログインしたユーザーは他のユーザーをフォローできる' do
      # source1を投稿したユーザーとしてログインする
      sign_in(@source1.user)
      # source2を検索する
      fill_in 'キーワード', with: @source2.content
      select @source2.grade.name, from: 'q_grade_id_eq'
      select @source2.subject.name, from: 'q_subject_id_eq'
      select @source2.course.name, from: 'q_course_id_eq'
      find('input[name="commit"]').click
      # source2が表示される
      expect(page).to have_content(@source2.title)
      # source2の投稿者のマイページに遷移する
      visit user_path(@source2.user)
      # 「フォローする」ボタンが表示されている
      expect(page).to have_content('フォローする')
      # 「☆」をクリックすると、Relationshipモデルのカウントが1増える
      expect{
        click_on('フォローする')
        # Ajaxの処理完了を待つ
        sleep 0.5
      }.to change { Relationship.count }.by(1)
      # source2の詳細画面に遷移する
      expect(current_path).to eq(user_path(@source2.user))
      # 「フォロー解除」ボタンが表示されている
      expect(page).to have_content('フォロー解除')
      # 「フォロー解除」をクリックすると、Relationshipモデルのカウントが1減る
      expect{
        click_on('フォロー解除')
        # Ajaxの処理完了を待つ
        sleep 0.5
      }.to change { Relationship.count }.by(-1)
      # 「フォローする」ボタンが表示されている
      expect(page).to have_content('フォローする')
    end
  end

  context 'フォローができないとき' do
    it '自分自身をフォローすることはできない' do
      # source1を投稿したユーザーとしてログインする
      sign_in(@source1.user)
      # マイページへ遷移する
      visit user_path(@source1.user)
      # 「フォローする」ボタンは表示されていない
      expect(page).to have_no_content('フォローする')
    end

    it 'ログインしていないとフォローできない' do
      # トップページへ遷移する
      visit root_path
      # source1を検索する
      fill_in 'キーワード', with: @source1.content
      select @source1.grade.name, from: 'q_grade_id_eq'
      select @source1.subject.name, from: 'q_subject_id_eq'
      select @source1.course.name, from: 'q_course_id_eq'
      find('input[name="commit"]').click
      # source1が表示される
      expect(page).to have_content(@source1.title)
      # source1の投稿者のマイページに遷移する
      visit user_path(@source1.user)
      # 「フォローする」ボタンは表示されていない
      expect(page).to have_no_content('フォローする')
    end
  end

end