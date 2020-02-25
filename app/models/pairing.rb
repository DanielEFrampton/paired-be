class Pairing < ApplicationRecord
  belongs_to :pairer, class_name: 'User'
  belongs_to :pairee, class_name: 'User', optional: true

  def pairer_email
    pairer.email
  end

  def pairee_email
    pairee.email
  end

  def pairer_name
    pairer.name
  end

  def pairee_name
    pairee.name
  end         
end
