require 'optparse'
require 'xmpp4r'
include Jabber

class HomeController < ApplicationController
	#before_action :authenticate_user!

  def index
  	@users = User.all	
  end

  # def user_chat
  # 	if session.has_key?('user1') || session.has_key?('user2') || session.has_key?('password')
  # 		session.delete('user1')
  # 		session.delete('user2')
  # 		session.delete('password')
  # 	end
  # end	

  def  chat
  	@other_user = User.find(params[:id])
  	# session[:user1] = params[:data][:user1]
  	# session[:user2] = params[:data][:user2]
  	# session[:password] = params[:data][:password]
  end

  def send_message
  	begin
  		myJID = JID.new("#{params[:user_1]}@li345-119/li345-119")
		myPassword = "#{params[:password]}"

		to = "#{params[:user_2]}@li345-119/li345-119"
		subject = 'sub'

		cl = Client.new(myJID)
		cl.connect('178.79.176.119','5222')
		cl.auth(myPassword)
		body = "#{params[:message]}"
		#body = STDIN.readlines.join
		m = Message.new(to, body).set_type(:chat).set_id('2').set_subject(subject)
		puts m.to_s
		cl.send(m)
		cl.close

		render :json => {:status => true}
	rescue
		render :json => {:status => false}
	end	
  end

  def reg_user
      xmpp_client = XmppClient.new(params[:name])    
      xmpp_client.register(params[:password], {"email"=>"#{params[:email]}", "name"=>"#{params[:name]}"})
      xmpp_client.close
      render :json => {:status => "true"}
  end  
end
