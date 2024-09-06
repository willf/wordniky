require 'faraday'

module Wordnik
  class Client
    attr_accessor :configuration

    def initialize()
      @configuration = Configuration.new
    end

    def call(url, params)
      Faraday.new(url: url) do |conn|
        conn.request :url_encoded
        conn.adapter Faraday.default_adapter
        conn.response :json
        conn.request :json
      end.get(url, params)
    end

    def compose_url(path)
      "#{configuration.api_url}/#{configuration.api_version}/#{path}"
    end

    def normalize_params(params)
      params = Wordnik.to_camel_case(params)
      params[:api_key] = @configuration.api_key
      params
    end

    def call_with_path(path, params)
      url = compose_url(path)
      params = normalize_params(params)
      b = call(url, params).body
      Wordnik.to_snake_case(b)
    end

    def audio(word, params = {})
      call_with_path("word.json/#{word}/audio", params)
    end

    def definitions(word, params = {})
      call_with_path("word.json/#{word}/definitions", params)
    end

    def etymologies(word, params = {})
      call_with_path("word.json/#{word}/etymologies", params)
    end

    def examples(word, params = {})
      call_with_path("word.json/#{word}/examples", params)
    end

    def frequency(word, params = {})
      call_with_path("word.json/#{word}/frequency", params)
    end

    def hyphenation(word, params = {})
      call_with_path("word.json/#{word}/hyphenation", params)
    end

    def phrases(word, params = {})
      call_with_path("word.json/#{word}/phrases", params)
    end

    def pronunciations(word, params = {})
      call_with_path("word.json/#{word}/pronunciations", params)
    end

    def related_words(word, params = {})
      r = call_with_path("word.json/#{word}/relatedWords", params)
      r.is_a?(Array) ? r : [] # otherwise it was a 404 object {:status_code=>404, :error=>"Not Found", :message=>"Not found"}
    end

    def scrabble_score(word, params = {})
      answer = call_with_path("word.json/#{word}/scrabbleScore", params)
      answer[:value] || 0
    end

    def top_example(word, params = {})
      call_with_path("word.json/#{word}/topExample", params)
    end

    def random_word(params = {})
      call_with_path("words.json/randomWord", params)[:word]
    end

    def random_words(params = {})
      call_with_path("words.json/randomWords", params).map { |w| w[:word] }
    end

    # reverse_dictionary is deprecated
    # def reverse_dictionary(word, params = {})
    #   call_with_path("words.json/reverseDictionary", params)
    # end

    # search is deprecated
    # def search(query, params = {})
    #   call_with_path("words.json/search/#{query}", params)
    # end

    def word_of_the_day(params = {})
      call_with_path("words.json/wordOfTheDay", params)
    end

    alias_method :wotd, :word_of_the_day

    ## Extras!

    def rhymes(word, params = {})
      related_words("suffering", relationship_types: :rhyme).map { |r| r[:words] }.flatten
    end

    def antonyms(word, params = {})
      related_words(word, relationship_types: :antonym).map { |r| r[:words] }.flatten
    end

    def synonyms(word, params = {})
      related_words(word, relationship_types: :synonym).map { |r| r[:words] }.flatten
    end

    def hypernyms(word, params = {})
      related_words(word, relationship_types: :hypernym).map { |r| r[:words] }.flatten
    end

    def hyponyms(word, params = {})
      related_words(word, relationship_types: :hyponym).map { |r| r[:words] }.flatten
    end

    def equivalents(word, params = {})
      related_words(word, relationship_types: :equivalent).map { |r| r[:words] }.flatten
    end

  end
end
