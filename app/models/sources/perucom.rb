module Sources
  class Perucom
    attr_reader :movies, :theaters, :doc, :div_position, :schedules_bool, :schedules
    
    DOC          = Nokogiri::HTML(open('http://www.peru.com/entretenimiento/cine'))
    COUNTRY_CODE = "PE"

    def initialize(args = {})
      @doc            = args[:doc] || DOC
      @div_position   = args[:production] ? 0 : 1
      @schedules_bool = args[:schedules] || false
      
      @movies         = Sources::Perucom::Movie.new(doc: doc, perucom_div_position: div_position).all
      @theaters       = Sources::Perucom::Theater.new(doc: doc).all
      @movies         = Sources::Perucom::Schedules.new(movies: movies, theaters: theaters).add if schedules?
    end

    def fetch
      {movies: movies, theaters: theaters}
    end

    def self.country_code
      COUNTRY_CODE
    end

    private

    def schedules?
      schedules_bool
    end
  end
end