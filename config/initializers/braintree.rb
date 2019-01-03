Braintree::Configuration.environment = Rails.env.production? ? :production : :sandbox
Braintree::Configuration.merchant_id = "hsst2kkt55f4s9cz"
Braintree::Configuration.public_key = "ztqjzs2wmjm344mq"
Braintree::Configuration.private_key = "76c6309f7aa452b19137cfd8fb4e36ae"