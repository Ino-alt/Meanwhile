Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # トップページ：ランダムな国の「今」を表示する
  root "pages#index"

  # 更新ボタン用：セッションをリセットして新しい国をランダムに表示する
  post "refresh", to: "pages#refresh"

  # momentの一覧ページ：これまでの「今」と日記を振り返る
  # 日記の投稿：moment に紐づく entry を作成する
  resources :moments, only: [ :index ] do
    resources :entries, only: [ :create ]
  end
end
