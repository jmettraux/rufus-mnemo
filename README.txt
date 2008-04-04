
= rufus-mnemo

This gem was previously known as the "openwferu-kotoba" gem (http://jmettraux.wordpress.com/2007/04/23/gem-install-openwferu-kotoba/)

It provides methods for turning integer into easier to remember 'words' and vice-versa.

The module Rufus::Mnemo has all the explanation.

see also http://openwferu.rubyforge.org/kotoba.html


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


== license

MIT

