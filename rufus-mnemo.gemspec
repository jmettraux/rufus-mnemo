
Gem::Specification.new do |s|

  s.name = 'rufus-mnemo'
  s.version = '1.1.1'
  s.authors = [ 'John Mettraux' ]
  s.email = 'jmettraux@gmail.com'
  s.homepage = 'http://rufus.rubyforge.org/rufus-mnemo'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Turning (large) integers into japanese sounding words and vice versa'
  #s.license = "MIT"
  s.description = 'Turning (large) integers into japanese sounding words and vice versa'

  s.require_path = 'lib'
  #s.autorequire = 'rufus-mnemo'
  s.test_file = 'test/test.rb'
  s.has_rdoc = true
  s.extra_rdoc_files = %w[ README.txt ]
  s.rubyforge_project = 'rufus'

  #[ 'rufus-lru' ].each do |d|
  #    s.requirements << d
  #    s.add_dependency d
  #end

  files = FileList[ "{bin,docs,lib,test}/**/*" ]
  files.exclude 'rdoc'
  s.files = files.to_a
end

