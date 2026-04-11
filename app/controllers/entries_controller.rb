class EntriesController < ApplicationController
  # 日記の投稿：current_userのmomentに紐づくentryを作成してトップページに戻る
  def create
    moment = current_user.moments.find(params[:moment_id])
    moment.entries.create!(entry_params)
    redirect_to root_path
  end

  private

  # 投稿フォームから受け取るパラメータをbodyのみに限定する
  def entry_params
    params.require(:entry).permit(:body)
  end
end
