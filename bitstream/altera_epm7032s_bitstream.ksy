
meta:
  id: bitstream_altera_epm7032s
  file-extension: bit
  # byte-order: first-to-last
  # bit-order: lsb-first

  # imports:
  #   - epm7000s.ksy

enums:
  input_enable:
    1: disabled
    0: enabled

types:
  product_term:
    types:
      global_input_enable:
        seq:
          - id: normal
            type: b1
            enum: input_enable
          - id: inverted
            type: b1
            enum: input_enable

    seq:
      - id: global_inputs
        type: product_term::global_input_enable
        repeat: expr
        repeat-expr: 36
      - id: regional_foldback_enable
        type: b1
        enum: input_enable
        repeat: expr
        repeat-expr: 16

  product_terms:
    types:
      macrocell:
        seq:
          - id: product_terms
            type: product_term
            repeat: expr
            repeat-expr: 5

      lab:
        seq:
          - id: macrocells
            type: product_terms::macrocell
            repeat: expr
            repeat-expr: 16

      epm7032s:
        seq:
          - id: labs
            type: product_terms::lab
            repeat: expr
            repeat-expr: 2

  macrocell:
    # 13 bits
    seq:
      - id: product_term_enable
        type: b1
        repeat: expr
        repeat-expr: 5
      # FIXME:
      - id: clock_mux
        type: b2
      # FIXME:
      - id: clear_mux
        type: b2
      # FIXME:
      - id: enable_mux
        type: b2
      # FIXME:
      - id: global_clock_enable
        type: b2

  macrocells:
    types:
      epm7032s:
        seq:
          - id: macrocell
            type: macrocell
            repeat: expr
            repeat-expr: 2*16

  lab_signals:
    types:
      signal:
        # selectable from 4 global signals
        seq:
          - id: input_enable
            type: b1
            enum: input_enable
            repeat: expr
            repeat-expr: 4
    
      lab:
        # 36 signals from global routing pool
        seq:
          - id: signals
            type: lab_signals::signal
            repeat: expr
            repeat-expr: 36

      epm7032s:
        seq:
          - id: labs
            type: lab_signals::lab
            repeat: expr
            repeat-expr: 2

  output_enable_signals:
    types:
      global_output_enable:
        seq:
          - id: unknown
            type: b1
            repeat: expr
            repeat-expr: 5

      epm7032s:
        seq:
          - id: output_enable
            type: output_enable_signals::global_output_enable
            repeat: expr
            repeat-expr: 6

  io:
    enums:
      slew_rate:
        1: slow
        0: fast
  
    types:
      iob:
        seq:
          - id: output_enable_select
            type: b1
            repeat: expr
            repeat-expr: 3
          - id: slew_rate
            type: b1
            enum: io::slew_rate
          - id: unknown
            type: b1
            repeat: expr
            repeat-expr: 2
    
      epm7032s:
        seq:
          - id: iob
            type: io::iob
            repeat: expr
            repeat-expr: 32

  usercode:
    seq:
      - id: data
        type: u1
        repeat: expr
        repeat-expr: 4

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
