
meta:
  id: max7000s

enums:
  floating_gate:
    1: disabled
    0: enabled

types:
  #
  # Configures which of a product term's input signals are enabled
  #
  product_term:
    types:
      #
      # Selects an output signal from either the inverted
      # or the non-inverted variant of an input signal
      #
      global_input:
        seq:
          - id: enable
            type: b1
            enum: floating_gate
          - id: enable_inverted
            type: b1
            enum: floating_gate

    seq:
      - id: global_inputs
        type: product_term::global_input
        repeat: expr
        repeat-expr: 36
      - id: regional_foldback_enable
        type: b1
        enum: floating_gate
        repeat: expr
        repeat-expr: 16

  product_terms:
    types:
      #
      # Configures all product terms in a macrocell
      #
      macrocell:
        seq:
          - id: product_terms
            type: product_term
            repeat: expr
            repeat-expr: 5

      #
      # Configures all product terms in a LAB
      #
      lab:
        seq:
          - id: macrocells
            type: product_terms::macrocell
            repeat: expr
            repeat-expr: 16

  #
  # Configures the behaviour of a macrocell
  #
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

  #
  # Configures all macrocells in one LAB
  #
  macrocells:
    types:
      - id: lab
        type: macrocell
        repeat: expr
        repeat-expr: 16

  #
  # Selects one LAB signal out of four PIA signals
  #
  lab_router:
    seq:
      - id: input_enable
        type: b1
        enum: floating_gate
        repeat: expr
        repeat-expr: 4

  #
  # Selects all regional signals within a LAB
  # from all available PIA signals
  #
  lab_routers:
    types:
      - id: lab
        type: lab_router
        repeat: expr
        repeat-expr: 36


  output_enable_signals:
    enums:
      - id:

    types:
      global_output_enable:
        seq:
          - id: unknown
            type: b1
            repeat: expr
            repeat-expr: 5


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

