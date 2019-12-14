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
  system 'apt update && apt install zsh -y && apt install neovim -y'
  system 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y'
  system 'curl -L git.io/antigen > antigen.zsh'
  system "git config --global core.excludesfile '~/.gitignore'"
  system 'bundle install --binstubs'
  system 'touch .bashrc'
  system 'echo "export PATH=/root/bin:$PATH" >> .bashrc'
  system 'chsh -s /usr/bin/zsh'
  system 'exec zsh'
end
