require_relative 'lib/duck'

curl = Zeli.load('./spec/curls/get_users.sh')

response = `#{curl}`

puts response
puts 'supa!'
