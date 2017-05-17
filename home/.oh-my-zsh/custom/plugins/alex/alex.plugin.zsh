dog() { cd ~/Work/Dropongo/Development/$1; }
_dog() { _files -W ~/Work/Dropongo/Development/ -/; }
compdef _dog dog

work() { cd ~/Work/$1; }
_work() { _files -W ~/Work/ -/; }
compdef _work work

df() { cd ~/dotfiles/$1; }
_df() { _files -W ~/dotfiles/ -/; }
compdef _df df

wb() { cd ~/Work/WiseBubble/Development/$1; }
_wb() { _files -W ~/Work/WiseBubble/Development/ -/; }
compdef _wb wb




