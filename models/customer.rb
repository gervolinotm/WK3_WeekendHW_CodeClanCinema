require('pg')
require_relative('../db/sql_runner.rb')


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
      ) VALUES
    (
      $1,$2
    )
    RETURNING id;"
    values = [@name, @funds]
    results = SqlRunner.run(sql, values).first
    @id = results['id'].to_i
  end

  def update()
    sql = "UPDATE customers
    SET (
      name,
      funds
      ) =
      (
        $1,$2
      )
      WHERE id = $3;"
    values = [@name, @funds, @id]
    result = SqlRunner.run(sql, values)
    return result
  end

  def delete()
    sql = "DELETE FROM customers
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def film()
    sql = "SELECT * FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1;"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = Film.map_items(films)
    return result
  end

  def self.all()
    sql = "SELECT * FROM customers;"
    customers = SqlRunner.run(sql)
    Customer.map_items(customers)
  end

  def self.delete_all()
   sql = "DELETE FROM customers;"
   SqlRunner.run(sql)
  end

  def self.map_items(customer_data)
   result = customer_data.map { |customer| Customer.new(customer)}
   return result
  end



end
