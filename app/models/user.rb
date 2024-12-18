class User < ApplicationRecord
  has_many :articles, foreign_key: :author_id
  has_one_attached :avatar
  has_many :comments, dependent: :destroy


  def admin?
    admin
  end

  def self.from_omniauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    logger.debug "Utilisateur trouvé : #{@user.inspect}" # Log de l'utilisateur
    # Si l'utilisateur existe déjà, on le met à jour, sinon on le crée
    unless user
      user = User.create(
        name: auth.info.name,
        email: auth.info.email,
        provider: auth.provider,
        uid: auth.uid,
        password: Devise.friendly_token[0, 20]  # Génère un mot de passe aléatoire
      )
    end
    user
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: [:google_oauth2]
end
