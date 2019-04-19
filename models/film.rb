require('pg')
require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id, :title
  attr_accessor :price

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
