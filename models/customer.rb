require('pg')
require_relative('../db/sql_runner.rb')


class Customer

  attr_reader :id, :name
  attr_accessor :funds

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
