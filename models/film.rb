require 'pg'

class Film
  attr_accessor :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    db = PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close
  end

  def update()
    db = PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "UPDATE films SET
    (
      title,
      price
    )=
    (
      $1, $2
    )
    WHERE id =$3"
    values = [@title, @price, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def delete()
    db = PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "DELETE FROM films
    WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close
  end

  def Film.delete_all()
    db =PG.connect({dbname: 'cinema', host: 'localhost'})
    sql = "DELETE FROM films"
    values = []
    db.prepare("delete all", sql)
    db.exec_prepared("delete all", values)
    db.close
  end

end
