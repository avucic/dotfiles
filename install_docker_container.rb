# frozen_string_literal: true

require 'fileutils'
require 'pathname'
require 'optparse'

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

if RUBY_PLATFORM =~ /linux/
  system 'cd ~/'
  system 'apt-get update'
  system 'apt-get install zsh'
  system 'apt-get install lsof'
  system 'curl -LO https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage && chmod u+x nvim.appimage && ./nvim.appimage --appimage-extract'
  system 'chmod u+x nvim.appimage'
  system './nvim.appimage --appimage-extract'
  system 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y'
  system 'curl -L git.io/antigen > antigen.zsh'
  system "git config --global core.excludesfile '~/.gitignore'"
  # system 'npx install-peerdeps --dev eslint-config-airbnb-base'
  # system 'npm i --save-dev eslint-plugin-prefer-object-spread'
  system 'bundle install'
  system 'mv ~/.config/nvim/init.vim.new ~/.config/nvim/init.vim'
  system 'echo "export PATH=/root/squashfs-root/usr/bin:\$PATH" >> ~/.zshrc'
  system 'chsh -s $(which zsh)'
end
