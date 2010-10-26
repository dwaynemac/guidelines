require 'machinist/active_record'
require 'sham'

Sham.define do
  name { Faker::Name.first_name }
end

PadmaToken.blueprint do
  user  { User.find_or_create_by_drc_user("homer") }
  token { "asdfasfdasdfasdf" }
  secret { "asdfasdfasdf" }
  type { "PadmaToken" }
end

