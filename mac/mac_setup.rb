system 'defaults write -g InitialKeyRepeat -int 10' # normal minimum is 15 (225 ms)
system 'defaults write -g KeyRepeat -int 1' # normal minimum is 2 (30 ms)
system 'defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO'

system 'brew install zsh'
system 'curl -L git.io/antigen > antigen.zsh'
