;; extends
; (block_quote) @MarkdownBlockQuote
; (thematic_break) @MarkdownHorizontalLine
; (block_quote_marker)@MarkdownBlockQuote
; (block_continuation)@MarkdownBlockQuote
; (fenced_code_block_delimiter) @comment

(atx_h1_marker) @MarkdownHeaderMarkerH1
(atx_h2_marker) @MarkdownHeaderMarkerH2
(atx_h3_marker) @MarkdownHeaderMarkerH3
(atx_h4_marker) @MarkdownHeaderMarkerH4
(atx_h5_marker) @MarkdownHeaderMarkerH5
(atx_h6_marker) @MarkdownHeaderMarkerH6

(list_marker_dot) @text.title
(list_marker_minus) @text.title
(list_marker_star) @text.title
(pipe_table) @MarkdownTable
(pipe_table_header
  (pipe_table_cell) @MarkdownTableHeaderCell
)

; ((atx_h1_marker) @conceal (#set! conceal "█"))
; ((atx_h2_marker) @conceal (#set! conceal "█"))
; ((atx_h3_marker) @conceal (#set! conceal "󰉭"))
; ((atx_h4_marker) @conceal (#set! conceal "󰉮"))
; ((atx_h5_marker) @conceal (#set! conceal "󰉯"))
; ((atx_h6_marker) @conceal (#set! conceal "󰉰"))
;
; ((atx_heading
;   (atx_h1_marker) @_h1
;   (_) @h1))
; ((atx_heading
;   (atx_h2_marker) @_h2
;   (_) @h2))
; ((atx_heading
;   (atx_h3_marker) @_h3
;   (_) @h3))
; ((atx_heading
;   (atx_h4_marker) @_h4
;   (_) @h4))
; ((atx_heading
;   (atx_h5_marker) @_h5
;   (_) @h5))
; ((atx_heading
;   (atx_h6_marker) @_h6
;   (_) @h6))

; markdown meta section
(section
  (paragraph) @MarkdownMeta (#match? @MarkdownMeta "^Created.*"))


;; Conceal bullet points
; ([(list_marker_plus) (list_marker_star)]
;   @punctuation.special
;   (#offset! @punctuation.special 0 0 0 -1)
;   (#set! conceal "•"))
;
; ((list_marker_minus)
;   @punctuation.special
;   (#offset! @punctuation.special 0 0 0 -1)
;   (#set! conceal "—"))

(list_item [
  (list_marker_plus)
  (list_marker_minus)
  (list_marker_star)
  (list_marker_dot)
  (list_marker_parenthesis)
] @MarkdownListItemMarker )


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
;        (list_marker_star)]
;          @conceal (#set! conceal "◉")
;          (#offset! @conceal 0 1 0 -1)))
;

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

