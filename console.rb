require('pry-byebug')
require_relative('./models/ticket.rb')
require_relative('./models/film.rb')
require_relative('./models/customer.rb')

Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new({
  'name' => 'John',
  'funds' => '20'})
customer2 = Customer.new({
  'name' => 'Finn',
  'funds' => '25'})
customer3 = Customer.new({
  'name' => 'Darren',
  'funds' => '15'})

customer1.save
customer2.save
customer3.save

film1 = Film.new({
  'title' => 'Planes, Trains and Automobiles',
  'price' => '5'})
film2 = Film.new({
  'title' => 'The Great Outdoors',
  'price' => '6'})
film3 = Film.new({
  'title' => 'Uncle Buck',
  'price' => '7'})

film1.save
film2.save
film3.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film3.id})
ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id})
ticket3 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film2.id})

ticket1.save
ticket2.save
ticket3.save

binding.pry

nil
