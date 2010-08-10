
require 'rubygems'
require 'rake'


load 'lib/rufus/mnemo.rb'


#
# CLEAN

require 'rake/clean'
CLEAN.include('pkg', 'tmp', 'html')
task :default => [ :clean ]


#
# GEM

require 'jeweler'

Jeweler::Tasks.new do |gem|

  gem.version = Rufus::Mnemo::VERSION
  gem.name = 'rufus-mnemo'
  gem.summary = 'Turning (large) integers into japanese sounding words and vice versa'
  gem.description = %{
Turning (large) integers into japanese sounding words and vice versa'
  }
  gem.email = 'jmettraux@gmail.com'
  gem.homepage = 'http://github.com/jmettraux/rufus-mnemo/'
  gem.authors = [ 'John Mettraux' ]
  gem.rubyforge_project = 'rufus'

  gem.test_file = 'test/test.rb'

  #gem.add_dependency 'rufus-json', '>= 0.2.5'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'jeweler'

  # gemspec spec : http://www.rubygems.org/read/chapter/20
end
Jeweler::GemcutterTasks.new


#
# DOC

#begin
#  require 'yard'
#  YARD::Rake::YardocTask.new do |doc|
#    doc.options = [
#      '-o', 'html/rufus-cloche', '--title',
#      "rufus-cloche #{Rufus::Cloche::VERSION}"
#    ]
#  end
#rescue LoadError
#  task :yard do
#    abort "YARD is not available : sudo gem install yard"
#  end
#end

#
# make sure to have rdoc 2.5.x to run that
#
require 'rake/rdoctask'
Rake::RDocTask.new do |rd|
  rd.main = 'README.txt'
  rd.rdoc_dir = 'rdoc/rufus-mnemo'
  rd.rdoc_files.include('README.rdoc', 'CHANGELOG.txt', 'lib/**/*.rb')
  rd.title = "rufus-mnemo #{Rufus::Mnemo::VERSION}"
end


#
# TO THE WEB

task :upload_rdoc => [ :clean, :rdoc ] do

  account = 'jmettraux@rubyforge.org'
  webdir = '/var/www/gforge-projects/rufus'

  sh "rsync -azv -e ssh rdoc/rufus-mnemo #{account}:#{webdir}/"
end

