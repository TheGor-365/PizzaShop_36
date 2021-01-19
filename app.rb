require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require 'sqlite3'

set :database, { adapter: 'sqlite3', database: 'pizzashop.sqlite' }

class Product < ActiveRecord::Base
end

class Order < ActiveRecord::Base
end

configure do
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Hello stranger'
  end
end

before '/secure/*' do
  unless session[:identity]
    session[:previous_url] = request.path
    @error = 'Sorry, you need to be logged in to visit ' + request.path
    halt erb(:login_form)
  end
end

get '/' do
  @products = Product.all

  erb :index
end

get '/login/form' do
  erb :login_form
end

post '/login/attempt' do
  session[:identity] = params['username']
  where_user_came_from = session[:previous_url] || '/'
  redirect to where_user_came_from
end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
end

get '/secure/place' do
  erb 'This is a secret place that only <%=session[:identity]%> has access to!'
end

get '/about' do
  erb :about
end

post '/place_order' do
  @order = Order.create params[:order]

  erb :order_placed
end

post '/cart' do
  @orders_input = params[:orders]
  @items = parse_orders_input @orders_input

  @items.each do |item|
    item[0] = Product.find(item[0])
  end


  erb :cart
end

def parse_orders_input orders_input
  s1 = orders_input.split(/,/)
  arr = []

  s1.each do |x|
    s2 = x.split(/\=/)
    s3 = s2[0].split(/_/)

    id = s3[1]
    cnt = s2[1]

    arr2 = [id, cnt]
    arr.push arr2
  end
  return arr
end
