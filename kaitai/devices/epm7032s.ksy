
meta:
  id: bitstream_altera_epm7032s
  file-extension: bit
  # byte-order: first-to-last
  # bit-order: lsb-first
  imports:
    - ../bitstream/max7000s.ksy

types:
  bitstream_altera_epm7032s:
    seq:
      - id: product_term_config
        type: product_terms::lab
        repeat: expr
        repeat-expr: 2

      - id: macrocell_config
        type: macrocells::lab
        repeat: expr
        repeat-expr: 2

      - id: lab_router_config
        type: lab_routers::lab
        repeat: expr
        repeat-expr: 2

      - id: output_enable_config
        type: output_enable_signals::global_output_enable
        repeat: expr
        repeat-expr: 6



seq:
  - id: product_terms
    type: product_terms::epm7032s
  - id: macrocells
    type: macrocells::epm7032s
  - id: lab_signals
    type: lab_signals::epm7032s
  - id: output_enable_signals
    type: output_enable_signals::epm7032s
  - id: io
    type: io::epm7032s
  - id: usercode
    type: usercode
