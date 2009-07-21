
= rufus-mnemo

This gem provides methods for turning integer into easier to remember 'words' and vice-versa.

The module Rufus::Mnemo has all the explanation.


== getting it

  sudo gem install rufus-mnemo

or at

http://rubyforge.org/frs/?group_id=4812


== usage

  require 'rubygems'
  require 'rufus/mnemo'
  
  s = Rufus::Mnemo::from_integer 125704
  
  puts s
    # => 'karasu'
  
  i = Rufus::Mnemo::to_integer s
  
  puts i
    # => 125704


== about negative integers

They are prefixed with the "wi" syllable (Thanks Stephan Wehner).

  p Rufus::Mnemo::from_integer -173866
    # => 'winamote'


= dependencies

None.


== mailing list

On the rufus-ruby list[http://groups.google.com/group/rufus-ruby] :

  http://groups.google.com/group/rufus-ruby


== issue tracker

http://rubyforge.org/tracker/?atid=18584&group_id=4812&func=browse


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

