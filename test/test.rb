
#
# Testing rufus-mnemo
#
# John Mettraux at openwfe.org
#
# Sun Mar 18 13:29:37 JST 2007
#

$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

require 'test/unit'
require 'rufus/mnemo'

#
# testing misc things
#

class MnemoTest < Test::Unit::TestCase

  #def setup
  #end

  #def teardown
  #end

  def test_0

    t = Time.now
    #puts t.to_f

    st = t.to_f * 1000 * 10

    #puts st

    st = Integer(st) % (10 * 1000 * 60 * 60)
    #st = 28340469

    s = Rufus::Mnemo::from_integer(st)

    st2 = Rufus::Mnemo::to_integer(s)
    s2 = Rufus::Mnemo::from_integer(st2)

    #puts st
    #puts s

    #puts st2
    #puts s2

    assert_equal s, s2
    assert_equal st, st2

    a = Rufus::Mnemo::split(s)

    assert_equal a.join, s

    #puts Rufus::Mnemo::to_integer("tunashima")
    #puts Rufus::Mnemo::to_integer("tsunashima")

    assert Rufus::Mnemo::is_mnemo_word("takeshi")

    assert Rufus::Mnemo::is_mnemo_word("tsunasima")
    assert Rufus::Mnemo::is_mnemo_word("tunashima")

    assert (not Rufus::Mnemo::is_mnemo_word("dsfadf"))
    assert (not Rufus::Mnemo::is_mnemo_word("takeshin"))
  end

  def test_zero

    assert_equal '', Rufus::Mnemo::from_integer(0)
    assert_equal 0, Rufus::Mnemo::to_integer('')
  end

  def test_negatives

    assert_equal -35, Rufus::Mnemo::to_integer('wina')
    assert_equal 'wina', Rufus::Mnemo::from_integer(-35)

    assert_equal -1, Rufus::Mnemo::to_integer('wibe')
    assert_equal 'wibe', Rufus::Mnemo::from_integer(-1)
  end

  def test_wi_bad_position

     %w(wi wiwi bewi nawi nabewi nawibe nawiwi).each do |bad_mnemo|

       error = assert_raise RuntimeError do
         Rufus::Mnemo::to_integer(bad_mnemo)
       end
       assert_equal "did not find syllable 'wi'", error.to_s
     end
   end
end

