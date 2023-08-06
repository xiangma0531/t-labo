require 'rails_helper'

RSpec.describe "コメント投稿", type: :system do
  before do
    @source1 = FactoryBot.create(:source)
    @source2 = FactoryBot.create(:source)
    @comment = FactoryBot.create(:comment)
  end

  context 'コメントの投稿ができるとき' do
    it 'ログインしたユーザーは他のユーザーの記事にコメントを投稿できる' do
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
      # フォームに情報を入力する
      fill_in 'comment[text]', with: @comment.text
      # 「コメントする」ボタンをクリックすると、Commentモデルのカウントが1増える
      expect{
        find('input[name="commit"]').click
      }.to change { Comment.count }.by(1)
      # source2の詳細画面に遷移する
      expect(current_path).to eq(source_path(@source2))
      # 詳細画面に投稿したコメントとコメント投稿者名(source1の投稿者名)が表示されている
      expect(page).to have_content(@comment.text)
      expect(page).to have_content(@source1.user.name)
    end
  end

  context 'コメントの投稿ができないとき' do
    it '何も入力しなければコメントは投稿できない' do
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
      # フォームに何も入力しない
      fill_in 'comment[text]', with: ""
      # 「コメントする」ボタンをクリックしても、Commentモデルのカウントは変わらない
      expect{
        find('input[name="commit"]').click
      }.to change { Comment.count }.by(0)
      # source2の詳細画面に戻り、エラーメッセージが表示される
      expect(current_path).to eq(source_comments_path(@source2))
      expect(page).to have_content('コメントを入力してください')
    end

    it '自分が投稿した記事にはコメントできない' do
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
      # source1の詳細ページにテキストエリアと「コメントする」ボタンは表示されていない
      expect(page).to have_no_selector('textarea')
      expect(page).to have_no_content('コメントする')
    end



    it 'ログインしていないとコメントは投稿できない' do
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
      # source1の詳細ページにテキストエリアと「コメントする」ボタンは表示されていない
      expect(page).to have_no_selector('textarea')
      expect(page).to have_no_content('コメントする')
    end
  end

end