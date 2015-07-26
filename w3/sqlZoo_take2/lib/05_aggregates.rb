# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def example_sum
  execute(<<-SQL)
    SELECT
      SUM(population)
    FROM
      countries
  SQL
end

def continents
  # List all the continents - just once each.
  execute(<<-SQL)
    SELECT
      DISTINCT continent
    FROM
      countries
  SQL
end

def africa_gdp
  # Give the total GDP of Africa.
  execute(<<-SQL) 
    SELECT
      SUM(gdp)
    FROM
      countries
    WHERE
      continent = 'Africa'
  SQL
end

def area_count
  # How many countries have an area of more than 1,000,000?
  execute(<<-SQL)
    SELECT
      COUNT(name)
    FROM
      countries
    WHERE
      area > 1000000
  SQL
end

def group_population
  # What is the total population of ('France','Germany','Spain')?
  execute(<<-SQL)
    SELECT
      SUM(population)
    FROM
      countries
    WHERE
      name IN ('France', 'Germany', 'Spain')
  SQL
end

def country_counts
  # For each continent show the continent and number of countries.
  execute(<<-SQL)
    SELECT
      DISTINCT c.continent, COUNT(DISTINCT c.name)
    FROM
      countries AS c
    JOIN
      countries AS c2 ON c2.continent = c.continent
    GROUP BY
      c.continent
  SQL
end

def populous_country_counts
  # For each continent show the continent and number of countries with
  # populations of at least 10 million.
  execute(<<-SQL)
    SELECT
      c.continent, COUNT(DISTINCT c.name)
    FROM 
      countries AS c
    JOIN
      countries AS c2 ON c.continent = c2.continent
    WHERE
      c.population >= 10000000
    GROUP BY
      c.continent
  SQL
end

def populous_continents
  # List the continents that have a total population of at least 100 million.
  execute(<<-SQL)
    SELECT
      c.continent
    FROM
      countries AS c
    JOIN   
      countries AS c2 ON c.continent = c2.continent
    GROUP BY
      c.continent
    HAVING
      SUM(DISTINCT c2.population) >= 100000000
  SQL
end
