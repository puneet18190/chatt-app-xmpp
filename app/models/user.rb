class User < ActiveRecord::Base
	require 'xmpp_client'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

	#after_create :register_on_server

  def after_confirmation
    register_on_server()
  end

  private
    def register_on_server
    	xmpp_client = XmppClient.new(self.email.gsub("@","!"))    
    	xmpp_client.register(self.user_password, {"email"=>"#{self.email.gsub("@","!")}@li345-119", "name"=>"#{self.chat_name}"})
    	xmpp_client.close
    end
end
