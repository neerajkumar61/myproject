class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :contacts
  

  # def self.from_omniauth(auth)  
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #   end
  # end
  


	def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
	  user = User.where(:provider => auth.provider, :uid => auth.uid).first
	  if user
	    return user
	  else
	    registered_user = User.where(:email => auth.uid + "@twitter.com").first
	    if registered_user
	      return registered_user
	    else

	      user = User.create(
	                          provider: auth.provider,
	                          uid: auth.uid,
	                          email: auth.uid+"@twitter.com",
	                          password: Devise.friendly_token[0,20],
	                        )
	    end

	  end
	end

	def self.connect_to_linkedin(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else

        user = User.create(
                            provider: auth.provider,
                            uid: auth.uid,
                            email: auth.info.email,
                            password: Devise.friendly_token[0,20],
                          )
      end

    end
  end 


  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
									          provider:access_token.provider,
									          email: data["email"],
									          uid: access_token.uid ,
									          password: Devise.friendly_token[0,20],
									        )
      end
    end
  end
  
  # def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
  #   data = access_token.info
  #   user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
  #   if user
  #     return user
  #   else
  #     registered_user = User.where(:email => access_token.info.email).first
  #     if registered_user
  #       return registered_user
  #     else 
  #       user = User.create!(
  #                            provider: auth.provider,
  #                            uid: auth.uid,
  #                            email: data.email,
  #                            password: Devise.friendly_token[0,20]
  #                          ) 
  #     end
  #   end
  # end


  # def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
  #   data = access_token.extra.raw_info
  #   if user = User.where(:email => data.email).first
  #     user
  #   else # Create a user with a stub password. 
  #     User.create!(:email => data.email, :password => Devise.friendly_token[0,20]) 
  #   end
  # end

  # def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  #   if user = User.find_by_email(auth.info.email)  # search your db for a user with email coming from fb
  #     return user  #returns the user so you can sign him/her in
  #   else
  #     user = User.create(
  #                          provider: auth.provider,    # Create a new user if a user with same email not present
  #                          uid: auth.uid,
  #                          email: auth.info.email,
  #                          password: Devise.friendly_token[0,20]
  #                        )
  #   end
  # end





  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20]
                          )
      end
      
    end
  end



end
