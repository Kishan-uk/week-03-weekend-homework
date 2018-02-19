require('pg')

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    db = PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close
  end

  def update()
    db = PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "UPDATE customers SET
    (
      name,
      funds
    )=
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@name, @funds, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def delete()
    db = PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "DELETE FROM customers
    WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close
  end

  def Customer.delete_all()
    db = PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "DELETE FROM customers"
    values = []
    db.prepare("delete all", sql)
    db.exec_prepared("delete all", values)
    db.close
  end

end
