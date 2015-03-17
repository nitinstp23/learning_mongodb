class User::AsSignUp < User

  validate do |record|
    record.errors.add(:password, :blank) if record.password_hash.blank?
  end

  validates_length_of :password, minimum: 8, message: I18n.t('user.validations.password.min_length')
  validates_confirmation_of :password, message: I18n.t('user.validations.password.confirmation')

end
