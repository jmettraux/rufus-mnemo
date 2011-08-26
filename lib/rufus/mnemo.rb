#--
# Copyright (c) 2007-2011, John Mettraux, jmettraux@gmail.com
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Made in Japan.
#++

module Rufus

  #
  # = Rufus::Mnemo
  #
  # This module contains methods for converting plain integers (base 10)
  # into words that are easier to read and remember.
  #
  # For example, the equivalent of the (base 10) integer 1329724967 is
  # "takeshimaya".
  #
  # Mnemo uses 70 of the syllables of the Japanese language, it is thus
  # a base 10 to base 70 converter.
  #
  # Mnemo is meant to be used for generating human readable (or more
  # easily rememberable) identifiers. Its first usage is within the
  # OpenWFEru Ruby workflow and bpm engine for generating 'kawaii'
  # business process instance ids.
  #
  #   require 'rubygems'
  #   require 'rufus/mnemo'
  #
  #   s = Rufus::Mnemo::from_integer 125704
  #
  #   puts s
  #     # => 'karasu'
  #
  #   i = Rufus::Mnemo::to_integer s
  #     # => 125704
  #
  #
  # == Mnemo from the command line
  #
  # You can use Mnemo directly from the command line :
  #
  #   $ ruby mnemo.rb kotoba
  #   141260
  #   $ ruby mnemo.rb rubi
  #   3432
  #   $ ruby mnemo.rb 2455
  #   nada
  #
  # might be useful when used from some scripts.
  #
  module Mnemo

    VERSION = '1.2.1'

    V = %w[ a e i o u ]
    C = %w[ b d g h j k m n p r s t z ]

    SYL = []

    C.each do |s|
      V.each do |v|
        SYL << s + v
      end
    end

    SYL << 'wa'
    SYL << 'wo'

    SYL << 'ya'
    SYL << 'yo'
    SYL << 'yu'

    SPECIAL = [
      [ 'hu', 'fu' ],
      [ 'si', 'shi' ],
      [ 'ti', 'chi' ],
      [ 'tu', 'tsu' ],
      [ 'zi', 'tzu' ]
    ]

    NEG = 'wi'
    NEGATIVE = /^#{NEG}(.+)$/

    # Turns the given integer into a Mnemo word.
    #
    def self.from_integer(integer)

      return "#{NEG}#{from_integer(-integer)}" if integer < 0

      s = from_i(integer)
      to_special(s)
    end

    # Turns the given Mnemo word to its equivalent integer.
    #
    def self.to_integer(string)

      s = from_special(string)
      to_i(s)
    end

    # Turns a simple syllable into the equivalent number.
    # For example Mnemo::to_number("fu") will yield 19.
    #
    def self.to_number(syllable)

      SYL.each_with_index do |s, index|
        return index if syllable == s
      end
      raise "did not find syllable '#{syllable}'"
    end

    # Given a Mnemo 'word', will split into its list of syllables.
    # For example, "tsunashima" will be split into
    # [ "tsu", "na", "shi", "ma" ]
    #
    def self.split(word)

      word = from_special(word)
      a = string_split(word)

      a_to_special(a)
    end

    # Returns if the string is a Mnemo word, like "fugu" or
    # "toriyamanobashi".
    #
    def self.is_mnemo_word(string)

      begin
        to_integer(string)
        true
      rescue #Exception => e
        false
      end
    end

    def self.string_split(s, result=[])

      return result if s.length < 1

      result << s[0, 2]

      string_split(s[2..-1], result)
    end

    def self.a_to_special(a)

      a.collect { |syl| SPECIAL.find { |aa, bb| syl == bb } || syl }
    end

    def self.to_special(s)

      SPECIAL.inject(s) { |ss, (a, b)| ss.gsub(a, b) }
    end

    def self.from_special(s)

      SPECIAL.inject(s) { |ss, (a, b)| ss.gsub(b, a) }
    end

    def self.from_i(integer)

      return '' if integer == 0

      mod = integer % SYL.length
      rest = integer / SYL.length

      rest = rest.to_i
      mod = mod.to_i
        # mathn prevention

      from_i(rest) + SYL[mod]
    end

    def self.to_i(s)

      return 0 if s.length == 0

      if m = s.match(NEGATIVE)
        return -1 * to_i(m[1])
      end

      SYL.length * to_i(s[0..-3]) + to_number(s[-2, 2])
    end

    class << self
      alias to_s from_i
    end
  end
end

#
# command line interface for Mnemo

if __FILE__ == $0

  arg = ARGV[0]

  if arg and arg != "-h" and arg != "--help"
    begin
      puts Rufus::Mnemo::from_integer(Integer(arg))
    rescue
      puts Rufus::Mnemo::to_integer(arg)
    end
  else
    puts
    puts "ruby #{$0} {arg}"
    puts
    puts "  If the arg is a 'Mnemo' word, will turn it into the equivalent"
    puts "  integer."
    puts "  Else, it will consider the arg as an integer and attempt at"
    puts "  turning it into a Mnemo [word]."
    puts
    puts "  Mnemo uses #{Rufus::Mnemo::SYL.length} syllables."
    puts
  end
end

