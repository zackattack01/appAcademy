# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
    SELECT
      m.title
    FROM
      movies AS m
    JOIN
      castings AS c ON c.movie_id = m.id
    JOIN 
      actors AS a ON c.actor_id = a.id
    WHERE
      a.name = 'Harrison Ford'
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
    SELECT
      m.title
    FROM 
      movies AS m
    JOIN
      castings AS c ON c.movie_id = m.id
    JOIN
      actors AS a ON a.id = c.actor_id
    WHERE
      a.name = 'Harrison Ford' AND c.ord > 1
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
    SELECT
      m.title, a.name
    FROM
      movies AS m
    JOIN
      castings AS c ON c.movie_id = m.id
    JOIN
      actors AS a ON a.id = c.actor_id
    WHERE
      c.ord = 1 AND m.yr = 1962
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
    SELECT
      m.yr, COUNT(m.id)
    FROM
      movies AS m
    JOIN 
      castings AS c ON c.movie_id = m.id
    JOIN 
      actors AS a ON a.id = c.actor_id
    WHERE
      a.name = 'John Travolta'
    GROUP BY
      m.yr
    HAVING
      COUNT(m.id) >= 2
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
    SELECT
      m1.title, a1.name
    FROM
      movies AS m1
    JOIN
      castings AS c1 ON c1.movie_id = m1.id
    JOIN 
      actors AS a1 ON a1.id = c1.actor_id
    WHERE
      m1.id IN (
                SELECT
                  m.id
                FROM
                  movies AS m 
                JOIN 
                  castings AS c ON c.movie_id = m.id
                JOIN 
                  actors AS a ON a.id = c.actor_id AND a.name = 'Julie Andrews'
                ) AND c1.ord = 1
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
    SELECT
      a.name
    FROM 
      actors AS a
    JOIN
      castings AS c ON c.actor_id = a.id AND c.ord = 1
    GROUP BY
      a.id
    HAVING
      COUNT(c.movie_id) >= 15
    ORDER BY
      a.name
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
    SELECT
      m.title, COUNT(a.id)
    FROM
      movies AS m 
    JOIN 
      castings AS c ON c.movie_id = m.id AND m.yr = 1978
    JOIN
      actors AS a ON a.id = c.actor_id
    GROUP BY
      m.id
    ORDER BY
      COUNT(a.id) DESC, m.title
  SQL
end

def colleagues_of_garfunkel
  # List all the people who have played alongside 'Art Garfunkel'.
  execute(<<-SQL)
    SELECT
      a.name
    FROM
      actors AS a
    JOIN 
      castings AS c ON c.actor_id = a.id
    JOIN
      castings AS c2 ON c2.movie_id = c.movie_id 
    JOIN
      actors AS a2 ON a2.id = c2.actor_id AND a2.name = 'Art Garfunkel'
    WHERE
      a.name != 'Art Garfunkel'
  SQL
end
