require('pry-byebug')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({'name' => 'Bob', 'funds' => '100'})
customer1.save()
customer2 = Customer.new({'name' => 'David', 'funds' => '15'})
customer2.save()
customer3 = Customer.new({'name' => 'Trish', 'funds' => '10'})
customer3.save()

film1 = Film.new({'title' => 'Avengers:End Game', 'price' => '12'})
film1.save()
film2 = Film.new({'title' => 'Shazam!', 'price' => '12'})
film2.save()
film3 = Film.new({'title' => 'Spiderman: Far From Home', 'price' => '12'})
film3.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket3.save()
ticket4 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket4.save()
ticket5 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket5.save()

# film1.title = 'Avengers: Infinity War'
# film1.update()
# film1.save()

# customer1.name = 'Bill'
# customer1.update()
# customer1.save()
# ticket1.delete()


binding.pry
nil
