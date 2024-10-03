# frozen_string_literal: true

require 'rspec'
require_relative '../lib/wordnik'

RSpec.describe Wordnik do
  describe '.to_timestamp_or_string' do
    it 'converts ISO 8601 string to Time' do
      expect(Wordnik.to_timestamp_or_string('2023-10-01T12:34:56Z')).to eq(Time.parse('2023-10-01T12:34:56Z'))
    end

    it 'converts date string to Date' do
      expect(Wordnik.to_timestamp_or_string('2023-10-01')).to eq(Date.parse('2023-10-01'))
    end

    it 'returns the original string if not a date or time' do
      expect(Wordnik.to_timestamp_or_string('random_string')).to eq('random_string')
    end

    it 'returns the original object if not a string' do
      expect(Wordnik.to_timestamp_or_string(123)).to eq(123)
    end
  end

  describe '.capitalize_simple' do
    it 'capitalizes the first letter of a string' do
      expect(Wordnik.capitalize_simple('hello')).to eq('Hello')
    end

    it 'returns the string unchanged if already capitalized' do
      expect(Wordnik.capitalize_simple('Hello')).to eq('Hello')
    end

    it 'returns an empty string if given an empty string' do
      expect(Wordnik.capitalize_simple('')).to eq('')
    end
  end

  describe '.lowercase_simple' do
    it 'lowercases the first letter of a string' do
      expect(Wordnik.lowercase_simple('Hello')).to eq('hello')
    end

    it 'returns the string unchanged if already lowercase' do
      expect(Wordnik.lowercase_simple('hello')).to eq('hello')
    end

    it 'returns an empty string if given an empty string' do
      expect(Wordnik.lowercase_simple('')).to eq('')
    end
  end

  describe '.to_underscore' do
    it 'converts CamelCase to snake_case' do
      expect(Wordnik.to_underscore('WordNik')).to eq('word_nik')
    end

    it 'converts module names to paths' do
      expect(Wordnik.to_underscore('Word::Nik')).to eq('word/nik')
    end

    it 'replaces dashes with underscores' do
      expect(Wordnik.to_underscore('word-nik')).to eq('word_nik')
    end
  end

  describe '.to_camel' do
    it 'converts snake_case to camelCase' do
      expect(Wordnik.to_camel('word_nik')).to eq('wordNik')
    end

    it 'converts snake_case with multiple underscores to camelCase' do
      expect(Wordnik.to_camel('word_nik_example')).to eq('wordNikExample')
    end

    it 'returns an empty string if given an empty string' do
      expect(Wordnik.to_camel('')).to eq('')
    end
  end

  describe '.to_snake_case' do
    it 'converts hash keys to snake_case' do
      hash = { 'CamelCaseKey' => 'value', 'AnotherKey' => { 'NestedKey' => 'nested_value' } }
      expected = { camel_case_key: 'value', another_key: { nested_key: 'nested_value' } }
      expect(Wordnik.to_snake_case(hash)).to eq(expected)
    end

    it 'returns arrays unchanged' do
      array = %w[CamelCaseKey AnotherKey]
      expected_array = %w[CamelCaseKey AnotherKey]
      expect(Wordnik.to_snake_case(array)).to eq(expected_array)
    end

    it 'handles nested arrays and hashes' do
      hash = { 'CamelCaseKey' => [{ 'NestedKey' => 'nested_value' }] }
      expected = { camel_case_key: [{ nested_key: 'nested_value' }] }
      expect(Wordnik.to_snake_case(hash)).to eq(expected)
    end
  end

  describe '.to_camel_case' do
    it 'converts hash keys to camelCase' do
      hash = { 'snake_case_key' => 'value', 'another_key' => { 'nested_key' => 'nested_value' } }
      expected = { snakeCaseKey: 'value', anotherKey: { nestedKey: 'nested_value' } }
      expect(Wordnik.to_camel_case(hash)).to eq(expected)
    end

    it 'returns arrays unchanged' do
      array = %w[snake_case_key another_key]
      expected_array = %w[snake_case_key another_key]
      expect(Wordnik.to_camel_case(array)).to eq(expected_array)
    end

    it 'handles nested arrays and hashes' do
      hash = { 'snake_case_key' => [{ 'nested_key' => 'nested_value' }] }
      expected = { snakeCaseKey: [{ nestedKey: 'nested_value' }] }
      expect(Wordnik.to_camel_case(hash)).to eq(expected)
    end
  end
end
