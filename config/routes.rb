# == Route Map
#
#                           Prefix Verb   URI Pattern                                                                              Controller#Action
#                letter_opener_web        /letter_opener                                                                           LetterOpenerWeb::Engine
#                      sidekiq_web        /sidekiq                                                                                 Sidekiq::Web
#                             root GET    /                                                                                        posts#index
#                            login GET    /login(.:format)                                                                         user_sessions#new
#                                  POST   /login(.:format)                                                                         user_sessions#create
#                           logout DELETE /logout(.:format)                                                                        user_sessions#destroy
#                            users GET    /users(.:format)                                                                         users#index
#                                  POST   /users(.:format)                                                                         users#create
#                         new_user GET    /users/new(.:format)                                                                     users#new
#                             user GET    /users/:id(.:format)                                                                     users#show
#                    post_comments GET    /posts/:post_id/comments(.:format)                                                       comments#index
#                                  POST   /posts/:post_id/comments(.:format)                                                       comments#create
#                 new_post_comment GET    /posts/:post_id/comments/new(.:format)                                                   comments#new
#                     edit_comment GET    /comments/:id/edit(.:format)                                                             comments#edit
#                          comment GET    /comments/:id(.:format)                                                                  comments#show
#                                  PATCH  /comments/:id(.:format)                                                                  comments#update
#                                  PUT    /comments/:id(.:format)                                                                  comments#update
#                                  DELETE /comments/:id(.:format)                                                                  comments#destroy
#                     search_posts GET    /posts/search(.:format)                                                                  posts#search
#                            posts GET    /posts(.:format)                                                                         posts#index
#                                  POST   /posts(.:format)                                                                         posts#create
#                         new_post GET    /posts/new(.:format)                                                                     posts#new
#                        edit_post GET    /posts/:id/edit(.:format)                                                                posts#edit
#                             post GET    /posts/:id(.:format)                                                                     posts#show
#                                  PATCH  /posts/:id(.:format)                                                                     posts#update
#                                  PUT    /posts/:id(.:format)                                                                     posts#update
#                                  DELETE /posts/:id(.:format)                                                                     posts#destroy
#                            likes POST   /likes(.:format)                                                                         likes#create
#                             like DELETE /likes/:id(.:format)                                                                     likes#destroy
#                    relationships POST   /relationships(.:format)                                                                 relationships#create
#                     relationship DELETE /relationships/:id(.:format)                                                             relationships#destroy
#                    read_activity PATCH  /activities/:id/read(.:format)                                                           activities#read
#              edit_mypage_account GET    /mypage/account/edit(.:format)                                                           mypage/accounts#edit
#                   mypage_account PATCH  /mypage/account(.:format)                                                                mypage/accounts#update
#                                  PUT    /mypage/account(.:format)                                                                mypage/accounts#update
#                mypage_activities GET    /mypage/activities(.:format)                                                             mypage/activities#index
# edit_mypage_notification_setting GET    /mypage/notification_setting/edit(.:format)                                              mypage/notification_settings#edit
#      mypage_notification_setting PATCH  /mypage/notification_setting(.:format)                                                   mypage/notification_settings#update
#                                  PUT    /mypage/notification_setting(.:format)                                                   mypage/notification_settings#update
#               rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#        rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#               rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#        update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#             rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
#
# Routes for LetterOpenerWeb::Engine:
# clear_letters DELETE /clear(.:format)                 letter_opener_web/letters#clear
# delete_letter DELETE /:id(.:format)                   letter_opener_web/letters#destroy
#       letters GET    /                                letter_opener_web/letters#index
#        letter GET    /:id(/:style)(.:format)          letter_opener_web/letters#show
#               GET    /:id/attachments/:file(.:format) letter_opener_web/letters#attachment

require 'sidekiq/web'

Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
    mount Sidekiq::Web, at: '/sidekiq'
  end
  root to: 'posts#index'

  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'

  resources :users, only: %i[index new create show]
  resources :posts, shallow: true do
    resources :comments
    collection do
      get :search
    end
  end
  resources :likes, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
  resources :activities, only: %i[] do
    patch :read, on: :member
  end

  namespace :mypage do
    resource :account, only: %i[edit update]
    resources :activities, only: %i[index]
    resource :notification_setting, only: %i[edit update]
  end
end
