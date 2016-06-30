require 'test_helper'
require 'minitest/pride'

class DbpediaFilmTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DbpediaFilm::VERSION
  end

  def test_that_it_gets_a_response
   md = DbpediaFilm::Metadata::by_title("Alien")
    assert_equal(md[:director],"Scott, Ridley")
  end
end
