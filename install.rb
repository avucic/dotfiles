#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'
require 'pathname'

# Recursively link files from source to target directory
def linkify(source_path, target_path)
  Dir.glob(File.join(source_path, '*'), File::FNM_DOTMATCH).each do |src_fn_path|
    src_pn = Pathname.new src_fn_path
    next if %w[. ..].include? src_pn.basename.to_s

    if src_pn.directory?
      FileUtils.mkdir_p File.join(target_path, src_pn.basename)
      linkify File.join(source_path, src_pn.basename), File.join(target_path, src_pn.basename)
    else
      FileUtils.ln_s src_pn, File.join(target_path, src_pn.basename), force: true
    end
  end
end
linkify File.join(__dir__, 'home'), ENV['HOME']

system 'defaults write -g InitialKeyRepeat -int 10' # normal minimum is 15 (225 ms)
system 'defaults write -g KeyRepeat -int 1' # normal minimum is 2 (30 ms)
system 'defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO'
