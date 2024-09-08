# Wordnik

A Ruby wrapper for the Wordnik API

## Description

This is a Ruby wrapper for the Wordnik API. Wordnik is an online dictionary with
an API for getting definitions, synonyms, antonyms, and more, as described it
[developer.wordnik.com](https://developer.wordnik.com). This gem provides
functions for the `word` and `words` endpoints of the API.

## Installation

Add the `wordnik` gem to your Gemfile.

To use the gem, you will need to sign up for a Wordnik API key at [developer.wordnik.com](https://developer.wordnik.com). Once you have your key, you can set it as an environment variable in your shell:

```sh
export WORDNIK_API_KEY=your_api_key
```

or in a yaml file called `.wordnik.yml`.

```yaml
wordnik_api_key: your_api_key
```

## Example Standalone Usage

```ruby
require 'wordnik'
client = Wordnik::Client.new
client.definitions('ruby').each do |definition|
  puts definition[:text]
end
```

## Notes

The original Wordnik gem was written in 2011; the last significant update was in 2013.
As a result, the original gem does not work well with the current Wordnik API.

This gem is a rewrite of the original gem, with a focus on the `word` and `words` endpoints,
and with minimizing dependencies. The official Wordnik documentation of the API is
at [developer.wordnik.com/docs](https://developer.wordnik.com/docs). Some of these
endpoints no longer work, and some of the data can be difficult to work with.

This gem provides a way to get the data as the API provides it, without any additional
clean up, but by default it will return results in a more useable format. All results
returned are returned as results from the API, interpreted as base Ruby objects. The
documentation for the methods in the gem describe the parameters and return formats
with a focus on the cleaned up results. Certain parameters technically allowed by the
API do not have an effect on the results returned by the API (in particular, the `useCanonical`
parameter), and so are not included in the documentation. Functions that return
deprecation notices are not included in the gem (in particular, `reverseDictionary`
and `search`).

In general the naming conventions of the methods in the gem use Ruby conventions, not
the conventions of the API. For example, the API uses `sourceDictionary` and `includePartOfSpeech`,
while the gem uses `source_dictionary` and `include_part_of_speech`. Generally,
symbols are used for parameters and keys. For example, consider the following call:

```ruby
client.definitions('erinaceous', limit:1)
```

The results look like this (showing only keys with values):

```ruby
[{:attribution_text=>"from The Century Dictionary.",
  :source_dictionary=>"century",
  :text=>"Belonging to the hedgehog family; resembling a hedgehog.",
  :word=>"erinaceous",
  :attribution_url=>"https://www.wordnik.com/colophon#century/",
  :wordnik_url=>"https://www.wordnik.com/words/erinaceous"
}]
```

## CLI

The gem includes a command line interface. To use it, install the gem and
run `script/console` from the command line. You see some information about the
use and a prompt. It can be helpful to use the console to explore the data
returned by the API.
