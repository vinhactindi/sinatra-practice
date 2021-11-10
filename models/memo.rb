# frozen_string_literal: true

require 'securerandom'
require 'pg'
require 'dotenv/load'

class Memo
  attr_reader :id, :title, :content

  def initialize(title:, content: nil, id: nil)
    @id = id
    @title = title&.strip
    @content = content&.strip
  end

  def save
    if @id
      sql = 'UPDATE Memo SET title=$1, content=$2 WHERE id=$3;'
      params = [title, content, @id]
    else
      sql = 'INSERT INTO Memo (id, title, content) VALUES ($1, $2, $3);'
      @id ||= SecureRandom.uuid
      params = [@id, @title, @content]
    end
    connection.exec_params(sql, params)
    self
  end

  def destroy
    sql = 'DELETE FROM Memo WHERE id=$1;'
    params = [@id]
    connection.exec_params(sql, params)
  end

  def self.find(id)
    sql = 'SELECT title, content FROM Memo WHERE id=$1;'
    params = [id]
    values = connection.exec_params(sql, params).values
    Memo.new(id: id, title: values[0][0], content: values[0][1])
  end

  def self.all
    sql = 'SELECT id, title FROM Memo ORDER BY id ASC'
    connection.exec_params(sql).values.map do |value|
      Memo.new(id: value[0], title: value[1])
    end
  end

  def self.migrate
    sql = "CREATE TABLE IF NOT EXISTS Memo
           (id VARCHAR(36) PRIMARY KEY,
           title VARCHAR(255),
           content TEXT);"
    connection.exec_params(sql)
  end

  def self.connection
    @connection ||= PG.connect(host: ENV['PG_HOST'],
                               user: ENV['PG_USER'],
                               password: ENV['PG_PASSWORD'],
                               dbname: ENV['PG_DBNAME'],
                               port: ENV['PG_PORT'])
  end
end
