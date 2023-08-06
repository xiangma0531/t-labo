require 'rails_helper'

RSpec.describe "メッセージ", type: :system do
  before do
    @source1 = FactoryBot.create(:source)
    @source2 = FactoryBot.create(:source)
    @room = FactoryBot.create(:room)
    @message1 = FactoryBot.create(:message)
    @message2 = FactoryBot.create(:message)
  end

  context 'メッセージが送信できるとき' do
    it 'ログインしたユーザーは他のユーザーとのチャットルームを作成し、メッセージを送信できる' do
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
      # 「チャットを始める」ボタンが表示されている
      expect(page).to have_selector('input[value="チャットを始める"]')
      # 「チャットを始める」ボタンをクリックすると、Roomモデルのカウントが1増える
      expect{
        click_on('チャットを始める')
      }.to change { Room.count }.by(1)
      # source2を投稿したユーザーとのチャット画面に遷移する
      expect(page).to have_content("#{@source2.user.name}さんとのDM")
      # メッセージ入力欄にメッセージを入力する
      fill_in 'message[message]', with: @message1.message
      # 「送信」をクリックすると、Messageモデルのカウントが1増える
      expect{
        click_on('送 信')
      }.to change { Message.count }.by(1)
      # 送信したメッセージが表示される
      expect(page).to have_content(@message1.message)
      # チャットルームの一覧に遷移すると、先ほど作成したsource2投稿者とのチャットルームが表示されている
      visit rooms_path
      expect(page).to have_content(@source2.user.name)
      # トップページからsource2を検索し、投稿者のマイページに遷移すると、「チャットへ」ボタンが表示されている
      visit root_path
      fill_in 'キーワード', with: @source2.content
      select @source2.grade.name, from: 'q_grade_id_eq'
      select @source2.subject.name, from: 'q_subject_id_eq'
      select @source2.course.name, from: 'q_course_id_eq'
      find('input[name="commit"]').click
      expect(page).to have_content(@source2.title)
      visit user_path(@source2.user)
      expect(page).to have_content('チャットへ')
      # 「チャットへ」ボタンをクリックしても、Roomモデルのカウントは変わらない
      expect{
        click_on('チャットへ')
      }.to change { Room.count }.by(0)
      # source2を投稿したユーザーとのチャット画面に遷移し、先ほど送信したmessage1が表示されている
      expect(page).to have_content("#{@source2.user.name}さんとのDM")
      expect(page).to have_content(@message1.message)
      # メッセージ入力欄にメッセージを入力する
      fill_in 'message[message]', with: @message2.message
      # 「送信」をクリックすると、Messageモデルのカウントが1増える
      expect{
        click_on('送 信')
      }.to change { Message.count }.by(1)
      # 送信したメッセージが表示される
      expect(page).to have_content(@message1.message)
      expect(page).to have_content(@message2.message)
      # ログアウト後、source2を投稿したユーザーとしてログインする
      visit user_path(@source1.user)
      click_on('ログアウト')
      sign_in(@source2.user)
      # チャットルーム一覧へ遷移すると、source1を投稿したユーザーとのチャットの履歴が表示されている
      visit rooms_path
      expect(page).to have_content(@source1.user.name)
      # source1を投稿したユーザーとのチャット画面に遷移する
      click_on(@source1.user.name)
      expect(page).to have_content("#{@source1.user.name}さんとのDM")
      # source1を投稿したユーザーから送信されたメッセージが表示されている
      expect(page).to have_content(@message1.message)
      expect(page).to have_content(@message2.message)
    end
  end

  context 'メッセージが送信できないとき' do
    it '入力欄が空欄ではメッセージを送信することはできない' do
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
      # 「チャットを始める」ボタンが表示されている
      expect(page).to have_selector('input[value="チャットを始める"]')
      # 「チャットを始める」ボタンをクリックすると、Roomモデルのカウントが1増える
      expect{
        click_on('チャットを始める')
      }.to change { Room.count }.by(1)
      # source2を投稿したユーザーとのチャット画面に遷移する
      expect(page).to have_content("#{@source2.user.name}さんとのDM")
      # メッセージ入力欄にメッセージを入力する
      fill_in 'message[message]', with: ''
      # 「送信」をクリックしても、Messageモデルのカウントは増えない
      expect{
        click_on('送 信')
      }.to change { Message.count }.by(0)
    end

    it 'ログインしていないとメッセージを送信できない' do
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
      # 「チャットを始める」ボタンが表示されていない
      expect(page).to have_no_selector('input[value="チャットを始める"]')
    end
  end

end