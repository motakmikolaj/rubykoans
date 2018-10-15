require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def isOne(dice)
  if dice == 1
    return 100
  elsif dice == 5
    return 50
  else
    return 0
  end
end

def isThree(dice)
  if dice[0] == 1
    return 1000
  else
    return dice[0]*100
  end
end

def areTheSame(dice)
  if (dice[0] == dice[1]) && (dice[1] == dice[2])
    return true
  else
    return false
  end
end

def score(dice)
  size = dice.length
  if size == 0
    return 0
  elsif size == 1
    return isOne(dice[0])
  elsif size == 2
    return isOne(dice[0]) + isOne(dice[1])
  elsif size == 3
    if areTheSame(dice)
      return isThree(dice)
    else return isOne(dice[0]) + isOne(dice[1]) + isOne(dice[2])
    end
  elsif size == 4
    dices = dice.sort
    if areTheSame([dices[0], dices[1], dices[2]])
      return isThree([dices[0], dices[1], dices[2]]) + isOne(dices[3])
    elsif areTheSame([dices[1], dices[2], dices[3]])
      return isThree([dices[1], dices[2], dices[3]]) + isOne(dices[0])
    else isOne(dices[0]) + isOne(dices[1]) + isOne(dices[2]) + isOne(dices[3])
    end
  elsif size == 5
    dices = dice.sort
    if areTheSame([dices[0], dices[1], dices[2]]) #0 1 2
      return isThree([dices[0], dices[1], dices[2]]) + isOne(dices[3]) + isOne(dices[4])
    elsif areTheSame([dices[1], dices[2], dices[3]]) #1 2 3
      return isThree([dices[1], dices[2], dices[3]]) + isOne(dices[0]) + isOne(dices[4])
    elsif areTheSame([dices[2], dices[3], dices[4]]) #2 3 4
      return isThree([dices[2], dices[3], dices[4]]) + isOne(dices[0]) + isOne(dices[1])
    else isOne(dices[0]) + isOne(dices[1]) + isOne(dices[2]) + isOne(dices[3])
    end
  else
    return 1
  end
end

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end
