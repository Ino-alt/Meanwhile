class MomentsController < ApplicationController
  # 一覧ページ：current_userのmomentを新しい順に全件取得する
  # entriesも同時に読み込んでN+1クエリを防ぐ
  def index
    @moments = current_user.moments
                            .includes(:country, :entries)
                            .order(created_at: :desc)
  end
end
