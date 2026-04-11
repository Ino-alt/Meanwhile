class PagesController < ApplicationController
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

  def index
    @current_moment = current_user.moments.find_by(id: session[:moment_id])

    if @current_moment&.occurred_at&.< (Time.now - 1.day)
      session.delete(:moment_id)
      @current_moment = nil
    end

    unless @current_moment
      @moment_country = Country.order("RANDOM()").first

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

  private

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
