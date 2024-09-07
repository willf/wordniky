require_relative '../lib/wordnik'
require 'vcr'
require 'rspec'

RSpec.configure do |config|
  # some (optional) config here
end

client = Wordnik::Client.new

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr'
  config.hook_into :faraday # or :fakeweb
  config.filter_sensitive_data('API_KEY') do |interaction|
    client.configuration.api_key
  end
end

describe Wordnik::Client do
  it "should have a configuration" do
    expect(client.configuration).to be_a Wordnik::Configuration
  end

  it "should be able to get the wotd" do
    VCR.use_cassette('wotd') do
      expect(client.wotd[:word]).to be_a String
    end
  end

  it "should be able to get the word of the day" do
    VCR.use_cassette('word_of_the_day') do
      expect(client.word_of_the_day[:word]).to be_a String
    end
  end

  it "should be able to get definitions" do
    VCR.use_cassette('definitions') do
      expect(client.definitions('ruby').first).to be_a Hash
    end
  end

  it "should be able to limit definitions to specific parts of speech" do
    VCR.use_cassette('definitions_noun') do
      defs = client.definitions('fish', part_of_speech: 'noun')
      parts_of_speech = defs.map { |d| d[:part_of_speech] }.uniq
      expect(parts_of_speech).to eq ['noun']
    end
  end


  it "should be able to get examples" do
    VCR.use_cassette('examples') do
      expect(client.examples('ruby')).to be_a Hash
    end
  end

  it "should be able to get related words" do
    VCR.use_cassette('related_words') do
      expect(client.related_words('ruby')).to be_an Array
    end
  end

  it "should be able to get top example" do
    VCR.use_cassette('top_example') do
      expect(client.top_example('ruby')).to be_a Hash
    end
  end

  it "should be able to get random word" do
    VCR.use_cassette('random_word') do
      expect(client.random_word).to be_a String
    end
  end

  it "should be able to get scrabble score" do
    VCR.use_cassette('scrabble_score') do
      expect(client.scrabble_score('ruby')).to be_an Integer
    end
  end

  it "should return a zero scrabble score for an non-Scrabble word" do
    VCR.use_cassette('scrabble_score_0') do
      expect(client.scrabble_score('asdfasdfasdf')).to eq 0
    end
  end

  it "should be able to get hyphenation" do
    VCR.use_cassette('hyphenation') do
      expect(client.hyphenation('ruby')).to be_an Array
    end
  end

  it "should be able to get pronunciations" do
    VCR.use_cassette('pronunciations') do
      expect(client.pronunciations('ruby')).to be_an Array
    end
  end

  it "should be able to get frequency" do
    VCR.use_cassette('frequency') do
      expect(client.frequency('ruby')).to be_a Hash
    end
  end

  it "should be able to get phrases" do
    VCR.use_cassette('phrases') do
      expect(client.phrases('ruby')).to be_an Array
    end
  end

  # The etymologies endpoint has been removed from this version of the API
  # it "should be able to get etymologies" do
  #   VCR.use_cassette('etymologies') do
  #     expect(client.etymologies('ruby')).to be_an Array
  #   end
  # end

  it "should be able to get random words" do
    VCR.use_cassette('random_words') do
      expect(client.random_words).to be_an Array
    end
  end

  it "should be able to get audio" do
    VCR.use_cassette('audio') do
      expect(client.audio('ruby')).to be_an Array
    end
  end

  it "should be able to get rhymes" do
    VCR.use_cassette('rhymes') do
      expect(client.rhymes('ruby')).to be_an Array
    end
  end

  it "should be able to get antonyms" do
    VCR.use_cassette('antonyms') do
      expect(client.antonyms('ugly')).to be_an Array
    end
  end

  it "should be able to get synonyms" do
    VCR.use_cassette('synonyms') do
      expect(client.synonyms('ugly')).to be_an Array
    end
  end

  it "should be able to get hypernyms" do
    VCR.use_cassette('hypernyms') do
      expect(client.hypernyms('dog')).to be_an Array
    end
  end

  it "should be able to get hyponyms" do
    VCR.use_cassette('hyponyms') do
      expect(client.hyponyms('mammal')).to be_an Array
    end
  end

  it "should be able to get equivalents" do
    VCR.use_cassette('equivalents') do
      expect(client.equivalents('happy')).to be_an Array
    end
  end
end
