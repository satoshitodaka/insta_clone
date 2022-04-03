require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーション' do
    it '画像は必須であること' do
      post = build(:post, images: nil)
      post.valid?
      expect(post.errors[:images]).to include('を入力してください')
    end

    it '本文は必須であること' do
      post = build(:post, body: nil)
      post.valid?
      expect(post.errors[:body]).to include('を入力してください')
    end

    it '本文は最大1000文字であること' do
      post = build(:post, body: 'a' * 1001)
      post.valid?
      expect(post.errors[:body]).to include('は1000文字以内で入力してください')
    end
  end

  describe 'スコープ' do
    describe 'body_contain' do
      let!(:post) { create(:post, body: 'hello world') }
      subject { Post.body_contain('hello') }
      it { is_expected.to include post }
    end
  end
end
