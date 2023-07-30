require 'rails_helper'

RSpec.describe "いいね", type: :system do
  before do
    @source1 = FactoryBot.create(:source)
    @source2 = FactoryBot.create(:source)
  end

  context 'いいねができるとき' do
    it 'ログインしたユーザーは他のユーザーの記事にいいねできる(詳細画面から)' do
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
      # source2の詳細ページに遷移する
      visit source_path(@source2)
      # 「いいね」ボタンが表示されている
      expect(page).to have_content('☆')
      # 「☆」をクリックすると、Likeモデルのカウントが1増える
      expect{
        click_on('☆')
        # Ajaxの処理完了を待つ
        sleep 0.5
      }.to change { Like.count }.by(1)
      # source2の詳細画面に遷移する
      expect(current_path).to eq(source_path(@source2))
      # 「いいね」後のボタンが表示されている
      expect(page).to have_content('★')
    end

    it 'ログインしたユーザーは他のユーザーの記事にいいねできる(一覧から)' do
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
      # 「いいね」ボタンが表示されている
      expect(page).to have_content('☆')
      # 「☆」をクリックすると、Likeモデルのカウントが1増える
      expect{
        click_on('☆')
        # Ajaxの処理完了を待つ
        sleep 0.5
      }.to change { Like.count }.by(1)
      # 「いいね」後のボタンが表示されている
      expect(page).to have_content('★')
    end
  end

  context 'いいねができないとき' do
    it '自分が投稿した記事にはいいねできない(詳細画面)' do
      # source1を投稿したユーザーとしてログインする
      sign_in(@source1.user)
      # source1を検索する
      fill_in 'キーワード', with: @source1.content
      select @source1.grade.name, from: 'q_grade_id_eq'
      select @source1.subject.name, from: 'q_subject_id_eq'
      select @source1.course.name, from: 'q_course_id_eq'
      find('input[name="commit"]').click
      # source1が表示される
      expect(page).to have_content(@source1.title)
      # source1の詳細ページに遷移する
      visit source_path(@source1)
      # 「いいね」ボタンは表示されていない
      expect(page).to have_no_content('☆')
    end

    it '自分が投稿した記事にはいいねできない(一覧)' do
      # source1を投稿したユーザーとしてログインする
      sign_in(@source1.user)
      # source1を検索する
      fill_in 'キーワード', with: @source1.content
      select @source1.grade.name, from: 'q_grade_id_eq'
      select @source1.subject.name, from: 'q_subject_id_eq'
      select @source1.course.name, from: 'q_course_id_eq'
      find('input[name="commit"]').click
      # source1が表示される
      expect(page).to have_content(@source1.title)
      # 「いいね」ボタンは表示されていない
      expect(page).to have_no_content('☆')
    end

    it 'ログインしていないといいねできない(詳細画面)' do
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
      # source1の詳細ページに遷移する
      visit source_path(@source1)
      # 「いいね」ボタンは表示されていない
      expect(page).to have_no_content('☆')
    end

    it 'ログインしていないといいねできない(一覧)' do
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
      # 「いいね」ボタンは表示されていない
      expect(page).to have_no_content('☆')
    end
  end

end