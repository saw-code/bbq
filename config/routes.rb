# frozen_string_literal: true

Rails.application.routes.draw do
  # дергаем спец. девайзовский метод, который генерит все нужные ему пути
  devise_for :users
  root 'events#index'

  resources :events do
    # вложенный ресурс комментов
    resources :comments, only: %i[create destroy]
    # вложенный ресурс подписок (см. rake routes)
    resources :subscriptions, only: %i[create destroy]
    # Вложенные в ресурс события ресурсы фотографий
    resources :photos, only: %i[create destroy]
  end

  resources :users, only: %i[show edit update]
end
