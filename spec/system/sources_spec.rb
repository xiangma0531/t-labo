require 'rails_helper'

RSpec.describe "記事投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @source = FactoryBot.create(:source)
    @image_path = Rails.root.join('public/images/dammy.png')
  end

  context '記事の投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのボタンが表示されている
      expect(page).to have_content('新規投稿')
      # 投稿ページに遷移する
      visit new_source_path
      # フォームに情報を入力する
      fill_in 'タイトル', with: @source.title
      select @source.grade.name, from: 'source_grade_id'
      select @source.subject.name, from: 'source_subject_id'
      select @source.course.name, from: 'source_course_id'
      fill_in '概要', with: @source.content
      attach_file('source[image]', @image_path, make_visible: true)
      # 「作成」ボタンをクリックすると、Sourceモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Source.count }.by(1)
      # ホーム画面に遷移する
      expect(current_path).to eq(root_path)
      # マイページに投稿した記事が表示されている
      visit user_path(@user)
      expect(page).to have_content(@source.title)
      # 詳細ページに遷移すると、投稿した記事の情報と画像がブラウザに表示されていることを確認する
      visit source_path(@source)
      expect(page).to have_content(@source.title)
      expect(page).to have_content(@source.grade.name)
      expect(page).to have_content(@source.subject.name)
      expect(page).to have_content(@source.course.name)
      expect(page).to have_content(@source.content)
      expect(page).to have_selector('img')
    end
  end

  context '記事の投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # ホーム画面に遷移する
      visit root_path
      # 新規投稿ページへのボタンが表示されていない
      expect(page).to have_no_content('新規投稿')
    end

    it '入力項目が空のとき、記事の投稿に失敗する' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのボタンが表示されている
      expect(page).to have_content('新規投稿')
      # 投稿ページに遷移する
      visit new_source_path
      # 何も入力せずに「作成ボタン」をクリックすると、新規投稿画面に戻り、Sourceモデルのカウントも増えない
      fill_in 'タイトル', with: ''
      select '校種を選択してください', from: 'source_grade_id'
      select '教科を選択してください', from: 'source_subject_id'
      select '科目を選択してください', from: 'source_course_id'
      fill_in '概要', with: ''
      expect{
        find('input[name="commit"]').click
      }.to change { Source.count }.by(0)
      expect(current_path).to eq(sources_path)
    end
  end

end

RSpec.describe "記事編集", type: :system do
  before do
    @source1 = FactoryBot.create(:source)
    @source2 = FactoryBot.create(:source)
    @image_path = Rails.root.join('public/images/dammy.png')
  end

  context '記事の編集ができるとき' do
    it 'ログインしたユーザーは記事の編集ができる' do
      # source1を投稿したユーザーとしてログインする
      sign_in(@source1.user)
      # マイページに遷移すると過去に投稿した記事が表示されている
      visit user_path(@source1.user)
      expect(page).to have_content(@source1.title)
      # 詳細ページへ遷移する
      visit source_path(@source1)
      # 「編集」ボタンが表示されている
      expect(page).to have_content('編集')
      # 記事編集ページに遷移する
      visit edit_source_path(@source1)
      # フォームに情報を入力する
      fill_in 'タイトル', with: "編集#{@source1.title}"
      select @source2.grade.name, from: 'source_grade_id'
      select @source2.subject.name, from: 'source_subject_id'
      select @source2.course.name, from: 'source_course_id'
      fill_in '概要', with: "編集#{@source1.content}"
      attach_file('source[image]', @image_path, make_visible: true)
      # 「作成」ボタンをクリックしても、Sourceモデルのカウントは増えない
      expect{
        find('input[name="commit"]').click
      }.to change { Source.count }.by(0)
      # 詳細画面に遷移する
      expect(current_path).to eq(source_path(@source1))
      # 詳細画面に編集した記事と画像が表示されている
      expect(page).to have_content("編集#{@source1.title}")
      expect(page).to have_content(@source2.grade.name)
      expect(page).to have_content(@source2.subject.name)
      expect(page).to have_content(@source2.course.name)
      expect(page).to have_content("編集#{@source1.content}")
      expect(page).to have_selector('img')
    end
  end

  context '記事の編集ができないとき' do
    it '自分以外のユーザーが投稿した記事は編集できない' do
      # source2を投稿したユーザーとしてログインする
      sign_in(@source2.user)
      # source1を検索する
      select @source1.grade.name, from: 'q_grade_id_eq'
      select @source1.subject.name, from: 'q_subject_id_eq'
      select @source1.course.name, from: 'q_course_id_eq'
      find('input[name="commit"]').click
      # source1が表示される
      expect(page).to have_content(@source1.title)
      # source1の詳細ページに遷移する
      visit source_path(@source1)
      # source1の詳細ページにsource1の情報が表示されている
      visit source_path(@source1)
      expect(page).to have_content(@source1.title)
      expect(page).to have_content(@source1.grade.name)
      expect(page).to have_content(@source1.subject.name)
      expect(page).to have_content(@source1.course.name)
      expect(page).to have_content(@source1.content)
      expect(page).to have_selector('img')
      # source1の詳細ページに編集ボタンは表示されていない
      expect(page).to have_no_content('編集')
      # source1の編集ページに遷移しようとしてもホーム画面に遷移する
      visit edit_source_path(@source1)
      expect(current_path).to eq(root_path)
    end
  end

end

RSpec.describe "記事削除", type: :system do
  before do
    @source1 = FactoryBot.create(:source)
    @source2 = FactoryBot.create(:source)
  end

  context '記事の削除ができるとき' do
    it 'ログインしたユーザーは記事の削除ができる' do
      # source1を投稿したユーザーとしてログインする
      sign_in(@source1.user)
      # マイページに遷移すると過去に投稿した記事が表示されている
      visit user_path(@source1.user)
      expect(page).to have_content(@source1.title)
      # 詳細ページへ遷移する
      visit source_path(@source1)
      # 「削除」ボタンが表示されている
      expect(page).to have_content('削除')
      # 「削除」ボタンをクリックすると削除モーダルが出現し、「削除する」ボタンと「キャンセル」ボタンが表示される
      find('#openModal').click
      expect(page).to have_content('削除する')
      expect(page).to have_content('キャンセル')
      # 「キャンセル」ボタンをクリックすると、記事は削除されず、モーダルが消える
      expect{
        find('#closeModal').click
      }.to change { Source.count }.by(0)
      expect(page).to have_no_content('削除する')
      expect(page).to have_no_content('キャンセル')
      # モーダルの「削除」ボタンをクリックすると、Sourceモデルのカウントが1減る
      find('#openModal').click
      expect{
        click_on('削除する')
      }.to change { Source.count }.by(-1)
      # ホーム画面に遷移する
      expect(current_path).to eq(root_path)
      # マイページに遷移すると削除した記事は表示されていない
      visit user_path(@source1.user)
      expect(page).to have_no_content(@source1.title)
    end
  end

  context '記事の削除ができないとき' do
    it '自分以外のユーザーが投稿した記事は削除できない' do
      # source2を投稿したユーザーとしてログインする
      sign_in(@source2.user)
      # source1を検索する
      select @source1.grade.name, from: 'q_grade_id_eq'
      select @source1.subject.name, from: 'q_subject_id_eq'
      select @source1.course.name, from: 'q_course_id_eq'
      find('input[name="commit"]').click
      # source1が表示される
      expect(page).to have_content(@source1.title)
      # source1の詳細ページに遷移する
      visit source_path(@source1)
      # source1の詳細ページにsource1の情報が表示されている
      visit source_path(@source1)
      expect(page).to have_content(@source1.title)
      expect(page).to have_content(@source1.grade.name)
      expect(page).to have_content(@source1.subject.name)
      expect(page).to have_content(@source1.course.name)
      expect(page).to have_content(@source1.content)
      expect(page).to have_selector('img')
      # source1の詳細ページに削除ボタンは表示されていない
      expect(page).to have_no_content('削除')
    end
  end

end