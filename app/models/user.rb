class User < AWS::Record::Model
  # Setup the attributes for the model
  # Many of these are managed by Devise

  ## Database authenticatable
  string_attr :email
  string_attr :encrypted_password

  ## Recoverable
  string_attr   :reset_password_token
  datetime_attr :reset_password_sent_at

  ## Rememberable
  datetime_attr :remember_created_at

  ## Trackable
  integer_attr  :sign_in_count
  datetime_attr :current_sign_in_at
  datetime_attr :last_sign_in_at
  string_attr   :current_sign_in_ip
  string_attr   :last_sign_in_ip

  ## Confirmable
  # string_attr   :confirmation_token
  # datetime_attr :confirmed_at
  # datetime_attr :confirmation_sent_at
  # string_attr   :unconfirmed_email # Only if using reconfirmable

  ## Lockable
  # integer_attr  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
  # string_attr   :unlock_token # Only if unlock strategy is :email or :both
  # datetime_attr :locked_at

  ## Token authenticatable
  # string_attr :authentication_token

  timestamps


  # Include some validation funcitons needed by Devise
  include ActiveModel::Validations::Callbacks

  # Some methods to fake out Devise
  def save opts = {}
    if valid?(opts)
      persisted? ? update : create
      clear_changes!
      true
    else
      false
    end
  end

  def valid? opts = {}
    opts = {} if opts.nil?
    opts = {:validate => true}.merge(opts)
    run_validations if opts[:validate]
    errors.empty?
  end


  # Now include devise model methods and 'configure' devise for this model
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # :recoverable, :rememberable,
  devise :database_authenticatable, :registerable,
         :trackable, :validatable

  
  

end
