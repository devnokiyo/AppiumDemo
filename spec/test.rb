require 'spec_helper'

describe "ログイン" do
  context '成功' do
    it "エラーダイアログが表示されないこと" do
      # 正しいID/パスワードでログインする
      operation_login('devnokiyo', 'abcd1234')
      # エラーダイアログが表示されないこと
      expect(dialog_title).to eq(nil)
    end
  end

  context '失敗' do
    before do
      # 不正なID/パスワードでログインする
      operation_login('devnokiyo', 'abcd123')
    end

    it 'エラーダイアログが表示されること' do
      # ダイアログのタイトルは「認証エラー」であること
      expect(dialog_title).to eq('認証エラー')
      # ダイアログのメッセージは「IDまたはパスワードが違います。」であること
      expect(dialog_message).to eq('IDまたはパスワードが違います。')
    end

    it '「OK」ボタンをタップするとエラーダイアログが消えること' do
      # ダイアログの「OK」ボタンをタップする
      tap_ok
      # ダイアログが非表示であること
      expect(dialog_title).to eq(nil)
    end
  end
end

describe 'ようこその画面' do
  context 'ログイン画面から遷移' do
    it "ログイン認証に成功すると、ようこその画面に遷移すること" do
      # 正しいID/パスワードでログインする
      operation_login('devnokiyo', 'abcd1234')
      # 「ようこそ」が表示されていること
      expect(label_title).to eq('ようこそ')
    end

    it "ログイン認証に失敗すると、ようこその画面に遷移しないこと" do
      operation_login('devnokiyo', 'abcd123')
      expect(label_title).to eq(nil)
    end
  end
end

# ログイン操作
#
# @param [String] id ID
# @param [String] password パスワード
def operation_login(id, password)
  find_element(:id, 'txtId').send_keys(id)
  find_element(:id, 'txtPassword').send_keys(password)
  find_element(:id, 'btnLogin').click
end

# ダイアログのタイトルを取得
#
# @return [String] ダイアログのタイトル
# @return [nil] ダイアログが表示されていない場合はnil
def dialog_title
  if ios?
    xpath = '//XCUIElementTypeStaticText[@name="認証エラー"]'
    return nil if find_elements(:xpath, xpath).empty?
    find_element(:xpath, xpath).value
  else
    id = 'alertTitle'
    return nil if find_elements(:id, id).empty?
    find_element(:id, id).text
  end
end

# ダイアログのメッセージを取得
#
# @return [String] ダイアログのメッセージ
# @return [nil] ダイアログが表示されていない場合はnil
def dialog_message
  if ios?
    id = 'IDまたはパスワードが違います。'
    return nil if find_elements(:id, id).empty?
    find_element(:id, id).value
  else
    id = 'message'
    return nil if find_elements(:id, id).empty?
    find_element(:id, id).text
  end
end

# 「OK」ボタンをタップ
#
def tap_ok
  if ios?
    find_element(:id, "OK").click
  else
    find_element(:id, "button2").click
  end
end

# ラベルのタイトルを取得
#
# @return [String] ラベルのタイトル
# @return [nil] ラベルが存在しない場合はnil
def label_title
  return nil if find_elements(:id, 'lblTitle').empty?
  find_element(:id, 'lblTitle').text
end
