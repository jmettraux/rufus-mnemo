
require 'rubygems'

require 'rake'
require 'rake/clean'
require 'rake/packagetask'
require 'rake/testtask'

#require 'rake/gempackagetask'
require 'rubygems/package_task'

#require 'rake/rdoctask'
require 'hanna/rdoctask'


RUFUS_MNEMO_VERSION = '1.1.0'

#
# GEM SPEC

gemspec = Gem::Specification.new do |s|

  s.name = 'rufus-mnemo'
  s.version = RUFUS_MNEMO_VERSION
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

  #[ 'rufus-lru' ].each do |d|
  #    s.requirements << d
  #    s.add_dependency d
  #end

  files = FileList[ "{bin,docs,lib,test}/**/*" ]
  files.exclude 'rdoc'
  s.files = files.to_a
end

#
# tasks

CLEAN.include('pkg', 'html')

task :default => [ :clean, :repackage ]


#
# TESTING

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList['test/test.rb']
  t.verbose = true
end

#
# PACKAGING

# the gem
#
Gem::PackageTask.new(gemspec) do |pkg|
  #pkg.need_tar = true
end

# the source zip
#
Gem::PackageTask.new(gemspec) do |pkg|
  pkg.need_zip = true
  pkg.package_files = FileList[
    'Rakefile',
    '*.txt',
    'lib/**/*',
    'test/**/*'
  ].to_a
  #pkg.package_files.delete("MISC.txt")
  class << pkg
    def package_name
      "#{@name}-#{@version}-src"
    end
  end
end


#
# DOCUMENTATION

Rake::RDocTask.new do |rd|

  rd.main = 'README.txt'
  rd.rdoc_dir = 'html/rufus-mnemo'
  rd.rdoc_files.include(
    'README.txt',
    'CHANGELOG.txt',
    'LICENSE.txt',
    #'CREDITS.txt',
    'lib/**/*.rb')
  #rd.rdoc_files.exclude('lib/tokyotyrant.rb')
  rd.title = 'rufus-mnemo rdoc'
  rd.options << '-N' # line numbers
  rd.options << '-S' # inline source
end

task :rrdoc => :rdoc do
  FileUtils.cp('doc/rdoc-style.css', 'html/rufus-mnemo/')
end

#
# WEBSITE

task :upload_website => [ :clean, :rrdoc ] do

  account = 'jmettraux@rubyforge.org'
  webdir = '/var/www/gforge-projects/rufus'

  sh "rsync -azv -e ssh html/rufus-mnemo #{account}:#{webdir}/"
end

