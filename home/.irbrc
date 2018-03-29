instance_eval(File.read("~/Gemfile"))
require 'rubygems'
require 'interactive_editor'
IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = '~/.irb-history'
