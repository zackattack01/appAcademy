require 'addressable/uri'
require 'rest-client'
require 'faker'
# class InvalidParamsError < RestClient::Exception
# end
# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users.html'
# ).to_s

# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users'
# ).to_s

# def create_user
# user_url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users',
# ).to_s

# begin
#   puts "User"
#   puts "#index:"
#   p RestClient.get(user_url)
#   puts
#   puts "#show first user:"
#   p RestClient.get(user_url + '/1')
#   puts
#   puts "#create"
#   p RestClient.post(user_url, { user: { username: "NEWB USER FROM BIN"}})
#   puts
#   p "#update"
#   p RestClient.put(user_url + '/14', { user: { username: "NEW NEW USER FROM BIN"}})
#   puts
#   puts "#destroy"
#   p RestClient.delete(user_url + '/14')
# rescue RestClient::Exception
#   puts "RestClient threw an error! (non-200 status code)"
# end
# contact_url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/contacts',
# ).to_s

# begin
#   puts "Contact"
#   puts "#index:"
#   p RestClient.get(contact_url)
#   puts
#   puts "#show first contact:"
#   p RestClient.get(contact_url + '/1')
#   puts
#   puts "#create"
#   p RestClient.post(contact_url, { contact: { name: Faker::Name.name,
#                                               email: Faker::Internet.email,
#                                               user_id: 14}})
#   puts
#   p "#update"
#   p RestClient.put(contact_url + '/5', { contact: { name: Faker::Name.name,
#                                                       email: Faker::Internet.email,
#                                                       user_id: 14}})
#   puts
#   puts "#destroy"
#   p RestClient.delete(contact_url + '/5')
# rescue RestClient::Exception
#   puts "RestClient threw an error! (non-200 status code)"
# end

nested_url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1/contacts',
).to_s

begin
  puts "nested contact stuff"
  puts "1/#index:"
  p RestClient.get(nested_url)
rescue RestClient::Exception
  puts "RestClient threw an error! (non-200 status code)"
end
