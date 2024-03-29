require('pg')
require_relative('../db/sql_runner.rb')


class Ticket

  attr_reader :customer_id, :film_id, :id

  def initialize(options)
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id
      ) VALUES
    (
      $1,$2
    )
    RETURNING id;"
    values = [@customer_id, @film_id]
    results = SqlRunner.run(sql, values).first
    @id = results['id'].to_i
  end

  def delete()
    sql = "DELETE FROM tickets
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets;"
    tickets = SqlRunner.run(sql)
    Ticket.map_items(tickets)
  end

  def self.delete_all()
   sql = "DELETE FROM tickets;"
   SqlRunner.run(sql)
  end

  def self.map_items(ticket_data)
   result = ticket_data.map { |ticket| Ticket.new(ticket)}
   return result
  end


end
