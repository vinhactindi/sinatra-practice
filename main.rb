# frozen_string_literal: true

require './models/memo'

require 'sinatra'
require 'sinatra/reloader'

get '/' do
  redirect :memos
end

get '/memos' do
  @memos = Memo.all
  slim :index
end

post '/memos' do
  @memo = Memo.new(id: params['id'], title: params['title'], content: params['content']).save
  redirect :memos
end

get '/memos/new' do
  slim :new
end

get '/memos/:id' do
  @memo = Memo.find(params[:id])

  if @memo.nil?
    slim :not_found
  else
    slim :show
  end
end

get '/memos/:id/edit' do
  @memo = Memo.find(params[:id])

  slim :edit
end

patch '/memos/:id' do
  @memo = Memo.new(id: params['id'], title: params['title'], content: params['content']).save
  redirect :memos
end

delete '/memos/:id' do
  @memo = Memo.find(params[:id])&.destroy
  redirect :memos
end

not_found do
  slim :not_found
end
