class PagesController < ApplicationController
  # 時間帯ごとの定型文。%s に国名を埋め込んで使用する
  FIXED_TEXTS = {
    morning: [
      "%s では今、朝の時間が流れています。",
      "%s の朝は、静かに始まろうとしています。",
      "%s の誰かが、今日最初の一歩を踏み出しています。"
    ],
    noon: [
      "%s では今、昼の光が降り注いでいます。",
      "%s の誰かが、今日の折り返し地点に立っています。",
      "%s では今、一日の真ん中を過ごしています。"
    ],
    evening: [
      "%s では今、夕暮れが街を染めています。",
      "%s の誰かが、窓の外の夕陽を眺めています。",
      "%s では今、一日の終わりが近づいています。"
    ],
    night: [
      "%s では今、夜が深まっています。",
      "%s の誰かが、今日を振り返る時間を過ごしています。",
      "%s では今、街の灯りがともっています。"
    ],
    midnight: [
      "%s では今、深夜の静けさが広がっています。",
      "%s の誰かが、眠れない夜を過ごしています。",
      "%s では今、ほとんどの人が夢の中にいます。"
    ]
  }.freeze

  # トップページ：セッションのmomentを使い回すか、新しく作成してビューに渡す
  def index
    @current_moment = current_user.moments.find_by(id: session[:moment_id])

    # momentが1日以上前の場合はセッションをリセットして作り直す
    if @current_moment&.occurred_at&.< (Time.now - 1.day)
      session.delete(:moment_id)
      @current_moment = nil
    end

    unless @current_moment
      @moment_country = Country.order("RANDOM()").first

      # countriesテーブルが空の場合はエラーメッセージを表示して終了
      unless @moment_country
        @error_message = "表示できる国のデータがありません。"
        return
      end

      @local_time     = Time.now.in_time_zone(@moment_country.timezone)
      @fixed_text     = fixed_text_for(@local_time.hour, @moment_country.name)
      @current_moment = current_user.moments.create!(
        country:     @moment_country,
        fixed_text:  @fixed_text,
        occurred_at: @local_time
      )
      session[:moment_id] = @current_moment.id
    end

    @moment_country = @current_moment.country
    @local_time     = @current_moment.occurred_at.in_time_zone(@moment_country.timezone)
    @fixed_text     = @current_moment.fixed_text
  end

  # 更新ボタン：セッションのmoment_idを削除してトップページにリダイレクトする
  def refresh
    session.delete(:moment_id)
    redirect_to root_path
  end

  private

  # 時刻（hour）と国名から、時間帯に応じた定型文をランダムに1文返す
  def fixed_text_for(hour, country_name)
    period = case hour
    when 4..10  then :morning
    when 11..14 then :noon
    when 15..17 then :evening
    when 18..21 then :night
    else             :midnight
    end
    FIXED_TEXTS[period].sample % country_name
  end
end
