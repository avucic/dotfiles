; extends

(block_quote) @comment
(block_quote_marker) @comment
(block_continuation) @comment
(fenced_code_block_delimiter) @comment
(atx_h1_marker) @MarkdownHeaderMarker
(atx_h2_marker) @MarkdownHeaderMarker
(atx_h3_marker) @MarkdownHeaderMarker
(atx_h4_marker) @MarkdownHeaderMarker
(atx_h5_marker) @MarkdownHeaderMarker
(atx_h6_marker) @MarkdownHeaderMarker
(list_marker_dot) @text.title
(list_marker_minus) @text.title
(list_marker_star) @text.title
(pipe_table)@MarkdownTable
(pipe_table_header
  (pipe_table_cell) @MarkdownTableHeaderCell
)

((atx_h1_marker) @conceal (#set! conceal ""))
((atx_h2_marker) @conceal (#set! conceal ""))
((atx_h3_marker) @conceal (#set! conceal ""))
((atx_h4_marker) @conceal (#set! conceal ""))
((atx_h5_marker) @conceal (#set! conceal ""))
((atx_h6_marker) @conceal (#set! conceal ""))
; ((block_quote_marker) @conceal (#set! conceal ""))

((atx_heading
  (atx_h1_marker) @_h1
  (_) @h1))
((atx_heading
  (atx_h2_marker) @_h2
  (_) @h2))
((atx_heading
  (atx_h3_marker) @_h3
  (_) @h3))
((atx_heading
  (atx_h4_marker) @_h4
  (_) @h4))
((atx_heading
  (atx_h5_marker) @_h5
  (_) @h5))


; ((shortcut_link) @conceal (#set! conceal "") (eq? @conceal "[ ]"))
; ((shortcut_link) @conceal (#set! conceal "☒") (eq? @conceal "[x]"))

; ((task_list_marker_checked) @conceal (#set! conceal ""))
; ((task_list_marker_unchecked) @conceal (#set! conceal "☒"))

; " syntax match TodoCheckbox '\v(\s+)?(-|\*)\s\[\s\]'hs=e-4 conceal cchar=
; " syntax match TodoCheckbox '\v(\s+)?(-|\*)\s\[X\]'hs=e-4 conceal cchar=
; " syntax match TodoCheckbox '\v(\s+)?(-|\*)\s\[-\]'hs=e-4 conceal cchar=☒
; " syntax match TodoCheckbox '\v(\s+)?(-|\*)\s\[\.\]'hs=e-4 conceal cchar=⊡
; " syntax match TodoCheckbox '\v(\s+)?(-|\*)\s\[o\]'hs=e-4 conceal cchar=⬕

; " syntax match TodoCheckbox '\[\s\]'hs=e-4 conceal cchar=
; " syntax match TodoCheckbox '\[X\]'hs=e-4 conceal cchar=
; " syntax match TodoCheckbox '\[-\]'hs=e-4 conceal cchar=☒
; " syntax match TodoCheckbox '\[\.\]'hs=e-4 conceal cchar=⊡
; " syntax match TodoCheckbox '\[o\]'hs=e-4 conceal cchar=⬕

; (list_item [
;   (list_marker_plus)
;   (list_marker_minus)
;   (list_marker_star)
;   (list_marker_dot)
;   (list_marker_parenthesis)
; ] @conceal [
;     (task_list_marker_checked)
;     (task_list_marker_unchecked)
; ](#set! conceal "◉"))

; (list
;     (list_item
;       [(list_marker_dot)
;        (list_marker_minus)
;        (list_marker_plus)
;        (list_marker_star)] @conceal (#set! conceal "◉")))


; (list
;     (list_item
;       (list
;         (list_item
;           [(list_marker_dot)
;            (list_marker_minus)
;            (list_marker_plus)
;            (list_marker_star)] @conceal (#set! conceal "•")))))
;
; ((task_list_marker_checked) @conceal (#set! conceal ""))
; ((task_list_marker_unchecked) @conceal (#set! conceal "☒"))

; (inline_link
;   ["]"] @conceal
;   (#set! conceal " "))
;
; (inline_link
;   "["  @conceal
;   (#set! conceal ""))
;
; (document
;   (list
;     (list_item
;       [(list_marker_dot)
;        (list_marker_minus)
;        (list_marker_plus)
;        (list_marker_star)] @conceal (#set! conceal "◉"))))
; (document
;   (list
;     (list_item
;       (list
;         (list_item
;           [(list_marker_dot)
;            (list_marker_minus)
;            (list_marker_plus)
;            (list_marker_star)] @conceal (#set! conceal "•"))))))

; ([
;   (atx_h1_marker)
;   (atx_h2_marker)
;   (atx_h3_marker)
;   (atx_h4_marker)
;   (atx_h5_marker)
;   (atx_h6_marker)
; ] @_conceal
; (#set! conceal ""))

