require 'singleton'
require 'sqlite3'
require_relative 'saveable'
require_relative 'user'
require_relative 'like'
require_relative 'reply'
require_relative 'question'
require_relative 'follows'

class QuestionsDatabase < SQLite3::Database

  include Singleton

  def initialize
    super('questions.db')

    self.results_as_hash = true
    self.type_translation = true
  end
end