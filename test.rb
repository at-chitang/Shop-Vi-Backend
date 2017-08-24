user = {}
user[:email] = 'ok'
info = %i[email first_name last_name birthday phone gender address province zipcode]

p info.map { |i| [i, user[i]] }.to_h

p info
