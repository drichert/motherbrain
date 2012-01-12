Motherbrain.tx do
  bytes(
    yamaha_id:                 0x43,
    device_number:             0x15,
    model_id:                  0x5E,
    parameter_address_high:    nil,
    parameter_address_middle:  nil,
    parameter_address_low:     nil,
    data_value_ms:             nil,
    data_value_ls:             nil
  )

  aliases(
    :pah => :parameter_address_high,
    :pam => :parameter_address_middle,
    :pal => :parameter_address_low,
    :dvm => :data_value_ms,
    :dvl => :data_value_ls
  )

  # Equivalent to
  # performance do
  #   common do
  #     # ...
  #   end
  # end
  performance_common do
    # Set fixed params. Inherits from #bytes call above
    bytes(
      pah: 0x10,
      pam: 0x00
    )

    # Bytes to use for outgoing value
    value_bytes(:dvm, :dvl)

    (0..11).each do |n|
      method("name_#{n}".to_sym).call(
        pal: 0x00 + n,
        min: 0x20,
        max: 0x7F
      )
    end

    category(pal: 0x0E, min: 0x00, max: 0x16)

    performance_volume(pal: 0x10, min: 0x00, max: 0x7F)

    performance_pan(
      pal: 0x11, min: 0x01, max: 0x7F,
      labels: {
        hard_left:   0x01,
        hard_right:  0x7F,
        center:      0x40
      }
    )

    performance_note_shift(
      pal: 0x12, min: 0x00, max: 0x30,
      labels: {
        octave_down_2:  0x00,
        octave_down:    0x0C,
        no_shift:       0x18,
        octave_up:      0x24,
        octave_up_2:    0x30
      }
    )

    individual_out(
      pal: 0x14, min: 0x00, max: 0x02,
      labels: {
        off:       0x00,
        pre_ins:   0x01,
        post_ins:  0x02
      }
    )

    fseq_part(
      pal: 0x15, min: 0x00, max: 0x04,
      labels: {
        off:     0x00,
        part_1:  0x01,
        part_2:  0x02,
        part_3:  0x03,
        part_4:  0x04
      }
    )

    fseq_bank(
      pal: 0x16, min: 0x.00, max: 0x01,
      labels: { int: 0x00, pre: 0x01 }
    )

    fseq_number(pal: 0x17, min: 0x00, max: 0x59)

    # 10.0 - 500.0
    fseq_speed_ratio(pal: 0x18, min: 0x00, max: 0x7F)

    # May be incorrect -- not clearly labeled in data list
    fseq_midi_clock(
      pal: 0x19, min: 0x00, max: 0x04,
      labels: {
        quarter: 0x00,
        half:    0x01,
        whole:   0x02,
        double:  0x03,
        quad:    0x04
      }
    )
  end

end
