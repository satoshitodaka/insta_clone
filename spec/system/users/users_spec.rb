require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do

  describe 'ユーザー登録' do
    context '入力情報が正しい場合' do
      it 'ユーザー登録ができる' do
        visit new_user_path
        fill_in '名前', with: 'sample user'
        fill_in 'メールアドレス', with: 'sample@instaclone.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録'
        expect(current_path).to eq root_path
        expect(page).to have_content 'ユーザーを作成しました'
      end
    end

    context '入力情報に誤りがある場合' do
      it 'ログインできないこと' do
        visit new_user_path
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'hogehoge'
        click_button '登録'
        # expect(current_path).to eq new_user_path
        expect(page).to have_content '名前を入力してください'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
        expect(page).to have_content 'ユーザーの作成に失敗しました'
      end
    end
  end
end
