require_relative 'lib/duck'

curl = Duck.load('/home/masa331/pracovni/code/ruby/curlduck/spec/curls/get_users.sh')

response = `#{curl}`

puts response
puts 'supa!'
