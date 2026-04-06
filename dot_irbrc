IRB.conf[:USE_AUTOCOMPLETE] = false

module IRB::Color
  TOKEN_SEQ_EXPRS.each do |token, (seq, exprs)|
    seq[0] = CYAN if seq[0] == BLUE
  end
  remove_const :CYAN
  CYAN = BLUE
end
