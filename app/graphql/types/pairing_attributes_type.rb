class Types::PairingAttributesType < Types::BaseInputObject
  argument :date, String, 'Date of pairing', required: true
  argument :time, String, 'Time of pairing', required: true
  argument :pairer, String, 'Firebase id of pairer', required: true
end
