# frozen_string_literal: true

require 'securerandom'
require 'json'

class Memo
  attr_accessor :id, :title, :content

  def initialize(title:, content:, id: nil)
    @id = id
    @title = title.strip
    @content = content.strip
  end

  def save
    return nil if @title.empty? || @content.empty?

    @id ||= SecureRandom.uuid

    File.write("public/data/#{@id}.json", to_json)
    self
  end

  def destroy
    File.delete("public/data/#{@id}.json") if File.exist?("public/data/#{@id}.json")
  end

  def self.find(id)
    data = JSON.parse(File.read("public/data/#{id}.json"))
    Memo.new(id: id, title: data['title'], content: data['content'])
  end

  def self.all
    files = Dir.glob('public/data/*').sort_by { |file| File.birthtime(file) }
    files.map do |file|
      data = JSON.parse(File.read(file))
      Memo.new(id: File.basename(file, '.json'), title: data['title'], content: data['content'])
    end
  end

  private

  def to_json(*_args)
    { id: @id, title: @title, content: @content }.to_json
  end
end
