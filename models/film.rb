require('pg')
require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @title = options['title']
    @price = options['price'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
      ) VALUES
    (
      $1,$2
    )
    RETURNING id;"
    values = [@title, @price]
    results = SqlRunner.run(sql, values).first
    @id = results['id'].to_i
  end

  def update()
    sql = "UPDATE films
    SET (
      title,
      price
      ) =
      (
        $1,$2
      )
      WHERE id = $3;"
    values = [@title, @price, @id]
    result = SqlRunner.run(sql, values)
    return result
  end

  def delete()
    sql = "DELETE FROM films
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customer()
    sql = "SELECT * FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE tickets.film_id = $1;"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    result = Customer.map_items(customers)
    return result
  end

  def self.all()
    sql = "SELECT * FROM films;"
    films = SqlRunner.run(sql)
    Film.map_items(films)
  end

  def self.delete_all()
   sql = "DELETE FROM films;"
   SqlRunner.run(sql)
  end

  def self.map_items(film_data)
   result = film_data.map { |film| Film.new(film)}
   return result
  end



end
