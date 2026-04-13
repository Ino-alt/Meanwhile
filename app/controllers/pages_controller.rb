class PagesController < ApplicationController
  # 時間帯ごとの定型文。%s に国名を埋め込んで使用する。すべて「%s では〜」形式で統一
  FIXED_TEXTS = {
    morning: [
      "%sでは今、朝の光が静かに広がっています。",
      "%sでは今、新しい一日が始まろうとしています。",
      "%sでは今、朝の気配が街に漂っています。"
    ],
    noon: [
      "%sでは今、昼の陽射しが降り注いでいます。",
      "%sでは今、一日の折り返し地点を迎えています。",
      "%sでは今、街が昼の賑わいに包まれています。"
    ],
    evening: [
      "%sでは今、夕暮れが街を染め始めています。",
      "%sでは今、西の空がだんだんと赤く染まっています。",
      "%sでは今、一日の終わりが近づいています。"
    ],
    night: [
      "%sでは今、夜の帳が下りています。",
      "%sでは今、街の灯りがともっています。",
      "%sでは今、人々が今日を振り返る時間を過ごしています。"
    ],
    midnight: [
      "%sでは今、深夜の静けさが広がっています。",
      "%sでは今、ほとんどの人が夢の中にいます。",
      "%sでは今、夜が最も深い時間を迎えています。"
    ]
  }.freeze

  # ランディングページ：アプリの説明スライドを表示する
  def top
  end

  # ホーム：セッションのmomentを使い回すか、新しく作成してビューに渡す
  def index
    @current_moment = current_user.moments.find_by(id: session[:moment_id])

    # momentが前日以前の場合はセッションをリセットして作り直す
    if @current_moment && @current_moment.occurred_at.to_date < Date.today
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
      session[:moment_id]   = @current_moment.id
      # 新しいmomentが作成されたときにポップアップを表示するフラグをセット
      session[:show_popup]  = true
    end

    @moment_country = @current_moment.country
    @local_time     = @current_moment.occurred_at.in_time_zone(@moment_country.timezone)
    @fixed_text     = @current_moment.fixed_text

    # ポップアップ表示フラグをビューに渡してからセッションから削除する
    @show_popup = session.delete(:show_popup)
  end

  # 更新ボタン：セッションをリセットしてポップアップを再表示する
  def refresh
    session.delete(:moment_id)
    session[:show_popup] = true
    redirect_to home_path
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
