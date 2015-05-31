#!/usr/bin/env ruby
# Redmine mail to ticket tool
# Copyright (C) 2015  Vítězslav Vitex Dvořák
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require 'yaml'

cfgFile = '/etc/redmine/default/mail2ticket.yml';

if File.exist?(cfgFile)
  config=YAML.load_file(cfgFile)
  config.each do |enviroment,projects|
    projects.each do |project,options|
      command = "bundle exec rake  --silent  redmine:email:receive_" + options["method"] + " RAILS_ENV=\"" + enviroment +  "\" host="+ options["host"] + " username=" + options["username"] + " password=" + options["password"] + "  move_on_success=read move_on_failure=failed project=" + project  + "  allow_override=project"
      Dir.chdir("/usr/share/redmine/") do
        exec(command)
      end
    end
  end

  #TODO: RAKE WAY
  #require 'rake'
  #rake = Rake.application
  #rake.init
  # you can import addition *.rake files
  # app.add_import '/usr/share/redmine/Rakefile'
  #rake.load_rakefile
  #rake['db:test:prepare'].invoke()

else
  puts " Config file " + cfgFile + " not exists"
end
  
