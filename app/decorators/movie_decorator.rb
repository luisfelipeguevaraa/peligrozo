class MovieDecorator
  attr_reader :movie, :user

  def self.build_with(array)
    array.map{ |movie| MovieDecorator.new(movie) }
  end

  def initialize(movie, user = nil )
    @movie = movie
    @user  = user
  end

  def id
    movie.id
  end

  def name
    movie.name
  end

  def theaters
    @theaters ||= movie.theaters
  end

  def schedules
    @schedules ||= movie.schedules
  end

  def created_at
    @created_at ||= movie.created_at
  end

  def tmdb_id
    @tmdb_id ||= movie.tmdb_id
  end

  def release_date
    @release_date ||= movie.release_date
  end

  def coming_soon?
    movie.coming_soon?
  end

  def trailer?
    movie.trailer?
  end

  def trailer
    movie.trailer
  end

  def youtube
    "http://www.youtube.com/embed/#{movie.trailer}"
  end

  def poster_path
    movie.poster_path
  end

  def overview
    if movie.overview.present?
      movie.overview
    else
      "La pelicula todavia no cuenta con una descripción."
    end
  end

  def overview_class
    "alert" unless movie.overview.present?
  end

  def favorite_theaters
    @favorite_theaters ||= user.favorite_theaters_by(movie: movie)
  end

  def first_schedule
    if favorite_theaters.empty?
      schedules.find_by(theater_id: theaters.first.id)
    else
      schedules.find_by(theater_id: favorite_theaters.first.id)
    end
  end

  def in_watchlist?
    @in_watchlist ||= user.movies.include?(movie)   
  end 

  def watchlist_id
    if in_watchlist?
      "button_delete_watchlist"
    else
      "button_add_watchlist"
    end
  end

  def watchlist_image
    if in_watchlist?
      "boton_remove_from_watchlist.png"
    else
      "boton_watchlist.png"
    end
  end

  def label_class
    if movie.playing_now?
      "cartelera-date"
    elsif movie.coming_soon?
      "upcoming-date"
    end 
  end
end
