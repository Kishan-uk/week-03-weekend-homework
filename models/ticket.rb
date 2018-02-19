require('pg')

class Ticket
  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    db = PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@customer_id, @film_id]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close
  end

  def update()
    db = PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "UPDATE tickets SET
    (
      customer_id,
      film_id
    )=
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def delete()
    db = PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "DELETE FROM tickets
    WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close
  end

  def Ticket.delete_all()
    db = PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "DELETE FROM tickets"
    values = []
    db.prepare("delete all", sql)
    db.exec_prepared("delete all", values)
    db.close
  end

  def films_booked()
    db = PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1"
    values =[@id]
    db.prepare("films booked", sql)
    result = db.exec_prepared("films booked", values)
    db.close
    return result.map {|film| Ticket.new(film_hash)}
  end

  def one_film()
    db = PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE customer_id = $1"
    values =[@id]
    db.prepare("one film booked", sql)
    result = db.exec_prepared("one film booked", values)
    db.close
    return result
  end

end
