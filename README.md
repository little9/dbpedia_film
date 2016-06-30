# DbpediaFilm


This gem uses is used to get metadata from DBPedia about film using the title. It's 
not exact, and sometimes DBPedia can have slow response times. If you are using this 
information on the web, you will want to cache the responses. 


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dbpedia_film'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dbpedia_film

## Usage

```ruby 
DbpediaFilm::Metadata::by_title("Alien")
```

```ruby
{:director=>"Scott, Ridley", :director_image=>"http://commons.wikimedia.org/wiki/Special:FilePath/Ridley_Scott_by_Gage_Skidmore.jpg", :producer=>"&pizza", :screenplay=>"Dan O'Bannon", :starring=>[], :composer=>"Jerry Goldsmith", :cinematographer=>"Derek Vanlint", :editing=>"&pizza", :studio=>"&pizza", :thumbnail=>"", :dist=>"", :gross=>0.0, :budget=>9.0, :date=>""}
```



# Tests
To run the tests:

```bash
rake test
```







