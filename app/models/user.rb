class User < ActiveRecord::Base
	require 'xmpp_client'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	after_create :register_on_server

  private
    def register_on_server
    	# jabber_credentials = self.build_jabber_credential
    	# jabber_credentials.jabber_id = "#{user.id}_#{user.name.split.join}_#{rand(100)}"
    	# jabber_credentials.jabber_password = '123456'
    	# jabber_credentials.save    
    	# user.register_jabber
    	xmpp_client = XmppClient.new(self.chat_name)    
    	xmpp_client.register(self.user_password, {"email"=>"#{self.email}", "name"=>"#{self.chat_name}"})
    	xmpp_client.close
    end
end
