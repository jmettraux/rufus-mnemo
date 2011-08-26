
= rufus-mnemo

This gem provides methods for turning integer into easier to remember 'words' and vice-versa.

The module Rufus::Mnemo has all the explanation.


== getting it

  gem install rufus-mnemo


== usage

  require 'rubygems'
  require 'rufus/mnemo'

  p Rufus::Mnemo.from_integer(125704)
  p Rufus::Mnemo.from_i(125704)
  p Rufus::Mnemo.to_s(125704)
    # => "karasu"

  p Rufus::Mnemo.to_integer('karasu')
  p Rufus::Mnemo.to_i('karasu')
  p Rufus::Mnemo.from_s('karasu')
    # => 125704


== about negative integers

They are prefixed with the "wi" syllable (Thanks Stephan Wehner).

  p Rufus::Mnemo.from_integer(-173866)
  p Rufus::Mnemo.to_s(-173866)
    # => 'winamote'


= dependencies

None.


== mailing list

On the rufus-ruby list[http://groups.google.com/group/rufus-ruby] :

  http://groups.google.com/group/rufus-ruby


== IRC

On freenode.net, the #ruote channel


== issue tracker

https://github.com/jmettraux/rufus-mnemo/issues


== source

http://github.com/jmettraux/rufus-mnemo

  git checkout git://github.com/jmettraux/rufus-mnemo.git


== author

John Mettraux, jmettraux@gmail.com
http://jmettraux.wordpress.com


== the rest of Rufus

http://rufus.rubyforge.org


== license

MIT

