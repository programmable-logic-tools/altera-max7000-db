meta:
  id: altera_epm7032s_bitstream
  file-extension: bit

types:
  product_term_global_input_enable:
    seq:
      - id: normal
        type: b1
      - id: inverted
        type: b1

  product_term:
    seq:
      - id: global_signals
        type: product_term_global_input_enable
        repeat: expr
        repeat-expr: 36
      - id: regional_macrocell_foldback_enable
        type: b1
        repeat: expr
        repeat-expr: 16

  macrocell_product_terms:
    seq:
      - id: product_terms
        type: product_term
        repeat: expr
        repeat-expr: 5

  lab_product_terms:
    seq:
      - id: macrocells
        type: macrocell_product_terms
        repeat: expr
        repeat-expr: 16

  macrocell:
    seq:
      - id: product_term_enable
        type: b1
        repeat: expr
        repeat-expr: 5

seq:
  - id: product_terms
    type: lab_product_terms
    repeat: expr
    repeat-expr: 2
  - id: macrocells
    type: macrocell







