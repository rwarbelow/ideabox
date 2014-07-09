require_relative 'test_helper'
require_relative '../lib/idea'

class IdeaTest < Minitest::Test
  def test_basic_idea
    idea = Idea.new("title", "description")
    assert_equal "title", idea.title
    assert_equal "description", idea.description
  end

  def test_ideas_can_be_liked
    idea = Idea.new("title", "description")
    assert_equal 0, idea.rank
    idea.like!
    assert_equal 1, idea.rank
    idea.like!
    assert_equal 2, idea.rank
  end

  def test_ideas_can_be_sorted_by_rank
    diet = Idea.new("diet", "cabbage soup")
    exercise = Idea.new("exercise", "long distance running")
    drink = Idea.new("drink", "carrot smoothie")

    exercise.like!
    exercise.like!
    drink.like!

    ideas = [drink, exercise, diet]

    assert_equal [diet, drink, exercise], ideas.sort
  end

  def test_ideas_have_an_id
    idea = Idea.new("dinner", "beef stew")
    idea.id = 1
    assert_equal 1, idea.id
  end

  def test_update_values
    idea = Idea.new("hello", "describing!")
    idea.title = "happy hour"
    idea.description = "mojitos"
    assert_equal "happy hour", idea.title
    assert_equal "mojitos", idea.description
  end

  def test_idea_can_be_updated
    idea = Idea.new("teach", "some ruby")
    id = IdeaStore.save(idea)

    idea = IdeaStore.find(id)
    idea.title = "cocktails"
    idea.description = "spicy tomato juice with vodka"

    IdeaStore.save(idea)

    assert_equal 1, IdeaStore.count

    idea = IdeaStore.find(id)
    assert_equal "cocktails", idea.title
    assert_equal "spicy tomato juice with vodka", idea.description
  end

  def test_a_new_idea
    idea = Idea.new("sleep", "all day")
    assert idea.new?
  end

  def test_an_old_idea
    idea = Idea.new('drink', "lots of water")
    idea.id = 1
    refute idea.new?
  end

  def test_delete_an_idea
    id1 = IdeaStore.save(Idea.new("idea1", "description1"))
    id2 = IdeaStore.save(Idea.new("idea2", "description2"))
    id3 = IdeaStore.save(Idea.new("idea3", "description3"))

    assert_equal ["idea1", "idea2", "idea3"], IdeaStore.all.map(&:title).sort
    IdeaStore.delete(id2)
    assert_equal ["idea1", "idea3"], IdeaStore.all.map(&:title).sort
  end

  def teardown
    IdeaStore.delete_all
  end
end
