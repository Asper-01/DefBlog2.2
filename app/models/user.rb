class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :articles, foreign_key: :author_id
  has_one_attached :avatar
  attr_accessor :remove_avatar
  before_save :purge_avatar, if: -> { remove_avatar == 'true' }
  has_many :comments, dependent: :destroy
  validates :cookies_consent, inclusion: { in: [true, false], message: "doit être accepté ou refusé" }, allow_nil: true
  # MAJ des préfs cookies choisies avant l'inscription
  after_create :set_default_cookies_consent, if: :new_record?
  validates :avatar, content_type: ['image/png',  'image/jpeg'], size: { less_than: 5.megabytes }
  def admin?
    admin
  end
  # Se connecter et créer un compte avec Google:
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

  private

    def purge_avatar
      avatar.purge
    end

  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: [:google_oauth2]
end
