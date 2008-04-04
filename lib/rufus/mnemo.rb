#
#--
# Copyright (c) 2007-2008, John Mettraux, jmettraux@gmail.com
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
#++
#

#
# "made in Japan"
#
# John Mettraux at openwfe.org
#

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
#     require 'rubygems'
#     require 'rufus/mnemo'
#     
#     s = Rufus::Mnemo::from_integer 125704
#     
#     puts s
#         # => 'karasu'
#     
#     i = Rufus::Mnemo::to_integer s
#     
#     puts i
#         # => 125704
#
#
# == Mnemo from the command line
#
# You can use Mnemo directly from the command line :
#
#     $ ruby mnemo.rb kotoba
#     141260
#     $ ruby mnemo.rb rubi
#     3432
#     $ ruby mnemo.rb 2455
#     nada
#
# might be useful when used from some scripts.
#
module Mnemo

    V = %w{ a e i o u }
    C = %w{ b d g h j k m n p r s t z }

    SYL = []

    C.each do |s|
        V.each do |v|
            SYL << s + v
        end
    end

    SYL << "wa"
    SYL << "wo"

    SYL << "ya"
    SYL << "yo"
    SYL << "yu"

    SPECIAL = [ 
        [ "hu", "fu" ],
        [ "si", "shi" ],
        [ "ti", "chi" ],
        [ "tu", "tsu" ],
        [ "zi", "tzu" ]
    ]

    #SYL2 = SYL.collect do |syl|
    #    s = syl
    #    SPECIAL.each do |a, b|
    #        if s == a
    #            s = b
    #            break
    #        end
    #    end
    #    s
    #end

    #
    # Turns the given integer into a Mnemo word.
    #
    def Mnemo.from_integer (integer)
        s = from_i(integer)
        to_special(s)
    end

    #
    # Turns the given Mnemo word to its equivalent integer.
    # 
    def Mnemo.to_integer (string)
        s = from_special(string)
        to_i(s)
    end

    #
    # Turns a simple syllable into the equivalent number.
    # For example Mnemo::to_number("fu") will yield 19.
    #
    def Mnemo.to_number (syllable)
        SYL.each_with_index do |s, index|
            return index if syllable == s
        end
        raise "did not find syllable '#{syllable}'"
    end

    #
    # Given a Mnemo 'word', will split into its list of syllables.
    # For example, "tsunashima" will be split into 
    # [ "tsu", "na", "shi", "ma" ]
    #
    def Mnemo.split (word)
        word = from_special(word)
        a = string_split(word)
        a_to_special(a)
    end

    #
    # Returns if the string is a Mnemo word, like "fugu" or 
    # "toriyamanobashi".
    #
    def Mnemo.is_mnemo_word (string)
        begin
            to_integer(string)
            true
        rescue #Exception => e
            false
        end
    end

    private

        def Mnemo.string_split (s, result=[])
            return result if s.length < 1
            result << s[0, 2]
            string_split(s[2..-1], result)
        end

        def Mnemo.a_to_special (a)
            a.collect do |syl|
                SPECIAL.each do |a, b|
                    if syl == a
                        syl = b
                        break
                    end
                end
                syl
            end
        end

        def Mnemo.to_special (s)
            SPECIAL.each do |a, b|
                s = s.gsub(a, b)
            end
            s
        end

        def Mnemo.from_special (s)
            SPECIAL.each do |a, b|
                s = s.gsub(b, a)
            end
            s
        end

        def Mnemo.from_i (integer)

            return '' if integer == 0

            mod = integer % SYL.length
            rest = integer / SYL.length

            from_i(rest) + SYL[mod]
        end

        def Mnemo.to_i (s)
            return 0 if s.length == 0
            SYL.length * to_i(s[0..-3]) + to_number(s[-2, 2])
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

