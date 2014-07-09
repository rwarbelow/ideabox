require_relative 'test_helper'
require_relative '../lib/idea'
require_relative '../lib/idea_store'

class IdeaStoreTest < Minitest::Test
  def test_save_and_retrieve_an_idea
    idea = Idea.new("celebrate", "with champagne")
    id1 = IdeaStore.save(idea)

    assert_equal 1, IdeaStore.count

    idea = Idea.new("dream", "of unicorns and rainbows")
    id2 = IdeaStore.save(idea)

    assert_equal 2, IdeaStore.count

    idea = IdeaStore.find(id1)
    assert_equal "celebrate", idea.title
    assert_equal "with champagne", idea.description

    idea = IdeaStore.find(id2)
    assert_equal "dream", idea.title
    assert_equal "of unicorns and rainbows", idea.description
  end
end
