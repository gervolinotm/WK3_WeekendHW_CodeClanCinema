require('pg')

class Ticket

  attr_reader :customer_id, :film_id, :id
  
  def initialize(options)
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @id = options['id'].to_i if options['id']
  end


end
