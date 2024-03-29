// File autogenerated by vlog_mem_map python project
// Date Generated: 2021-05-03 13:46:21.148411
// Configuration File: config.yml
// Memory Name: uart_i2c_user_clock
// Memory Word Width: 8
// Address Range: 128

/**************/
/* Field: LED */
/**************/
`define LED_field_addr 0
// Defines for register "leds"
`define leds_LSbit 0
`define leds_MSbit 7
`define leds_Sel 7:0
`define leds_Width 8
`define leds_LSbit_Addr 0
`define leds_MSbit_Addr 0
`define leds_LSbit_Pos 0
`define leds_MSbit_Pos 7
// Field LED length
`define LED_field_bit_length 8
`define LED_field_byte_length 1

/****************/
/* Field: RESET */
/****************/
`define RESET_field_addr 1
// Defines for register "reset"
`define reset_LSbit 8
`define reset_MSbit 8
`define reset_Sel 8:8
`define reset_Width 1
`define reset_LSbit_Addr 1
`define reset_MSbit_Addr 1
`define reset_LSbit_Pos 0
`define reset_MSbit_Pos 0
// Defines for register "i2c_rst_n"
`define i2c_rst_n_LSbit 9
`define i2c_rst_n_MSbit 9
`define i2c_rst_n_Sel 9:9
`define i2c_rst_n_Width 1
`define i2c_rst_n_LSbit_Addr 1
`define i2c_rst_n_MSbit_Addr 1
`define i2c_rst_n_LSbit_Pos 1
`define i2c_rst_n_MSbit_Pos 1
// Field RESET length
`define RESET_field_bit_length 2
`define RESET_field_byte_length 1

/**************/
/* Field: I2C */
/**************/
`define I2C_field_addr 2
// Defines for register "rv0_valid_pulse"
`define rv0_valid_pulse_LSbit 16
`define rv0_valid_pulse_MSbit 16
`define rv0_valid_pulse_Sel 16:16
`define rv0_valid_pulse_Width 1
`define rv0_valid_pulse_LSbit_Addr 2
`define rv0_valid_pulse_MSbit_Addr 2
`define rv0_valid_pulse_LSbit_Pos 0
`define rv0_valid_pulse_MSbit_Pos 0
// Defines for register "rv0_slave_address"
`define rv0_slave_address_LSbit 17
`define rv0_slave_address_MSbit 23
`define rv0_slave_address_Sel 23:17
`define rv0_slave_address_Width 7
`define rv0_slave_address_LSbit_Addr 2
`define rv0_slave_address_MSbit_Addr 2
`define rv0_slave_address_LSbit_Pos 1
`define rv0_slave_address_MSbit_Pos 7
// Defines for register "rv0_burst_count_wr"
`define rv0_burst_count_wr_LSbit 24
`define rv0_burst_count_wr_MSbit 25
`define rv0_burst_count_wr_Sel 25:24
`define rv0_burst_count_wr_Width 2
`define rv0_burst_count_wr_LSbit_Addr 3
`define rv0_burst_count_wr_MSbit_Addr 3
`define rv0_burst_count_wr_LSbit_Pos 0
`define rv0_burst_count_wr_MSbit_Pos 1
// Defines for register "rv0_burst_count_rd"
`define rv0_burst_count_rd_LSbit 26
`define rv0_burst_count_rd_MSbit 27
`define rv0_burst_count_rd_Sel 27:26
`define rv0_burst_count_rd_Width 2
`define rv0_burst_count_rd_LSbit_Addr 3
`define rv0_burst_count_rd_MSbit_Addr 3
`define rv0_burst_count_rd_LSbit_Pos 2
`define rv0_burst_count_rd_MSbit_Pos 3
// Defines for register "rv0_wdata0"
`define rv0_wdata0_LSbit 28
`define rv0_wdata0_MSbit 35
`define rv0_wdata0_Sel 35:28
`define rv0_wdata0_Width 8
`define rv0_wdata0_LSbit_Addr 3
`define rv0_wdata0_MSbit_Addr 4
`define rv0_wdata0_LSbit_Pos 4
`define rv0_wdata0_MSbit_Pos 3
// Defines for register "rv0_wdata1"
`define rv0_wdata1_LSbit 36
`define rv0_wdata1_MSbit 43
`define rv0_wdata1_Sel 43:36
`define rv0_wdata1_Width 8
`define rv0_wdata1_LSbit_Addr 4
`define rv0_wdata1_MSbit_Addr 5
`define rv0_wdata1_LSbit_Pos 4
`define rv0_wdata1_MSbit_Pos 3
// Defines for register "rv0_wdata2"
`define rv0_wdata2_LSbit 44
`define rv0_wdata2_MSbit 51
`define rv0_wdata2_Sel 51:44
`define rv0_wdata2_Width 8
`define rv0_wdata2_LSbit_Addr 5
`define rv0_wdata2_MSbit_Addr 6
`define rv0_wdata2_LSbit_Pos 4
`define rv0_wdata2_MSbit_Pos 3
// Defines for register "rv0_wdata3"
`define rv0_wdata3_LSbit 52
`define rv0_wdata3_MSbit 59
`define rv0_wdata3_Sel 59:52
`define rv0_wdata3_Width 8
`define rv0_wdata3_LSbit_Addr 6
`define rv0_wdata3_MSbit_Addr 7
`define rv0_wdata3_LSbit_Pos 4
`define rv0_wdata3_MSbit_Pos 3
// Defines for register "rv0_rd_wrn"
`define rv0_rd_wrn_LSbit 60
`define rv0_rd_wrn_MSbit 60
`define rv0_rd_wrn_Sel 60:60
`define rv0_rd_wrn_Width 1
`define rv0_rd_wrn_LSbit_Addr 7
`define rv0_rd_wrn_MSbit_Addr 7
`define rv0_rd_wrn_LSbit_Pos 4
`define rv0_rd_wrn_MSbit_Pos 4
// Defines for register "rv1_ready"
`define rv1_ready_LSbit 61
`define rv1_ready_MSbit 61
`define rv1_ready_Sel 61:61
`define rv1_ready_Width 1
`define rv1_ready_LSbit_Addr 7
`define rv1_ready_MSbit_Addr 7
`define rv1_ready_LSbit_Pos 5
`define rv1_ready_MSbit_Pos 5
// Defines for register "rv0_ready"
`define rv0_ready_LSbit 62
`define rv0_ready_MSbit 62
`define rv0_ready_Sel 62:62
`define rv0_ready_Width 1
`define rv0_ready_LSbit_Addr 7
`define rv0_ready_MSbit_Addr 7
`define rv0_ready_LSbit_Pos 6
`define rv0_ready_MSbit_Pos 6
// Defines for register "rv1_valid"
`define rv1_valid_LSbit 63
`define rv1_valid_MSbit 63
`define rv1_valid_Sel 63:63
`define rv1_valid_Width 1
`define rv1_valid_LSbit_Addr 7
`define rv1_valid_MSbit_Addr 7
`define rv1_valid_LSbit_Pos 7
`define rv1_valid_MSbit_Pos 7
// Defines for register "rv1_nack"
`define rv1_nack_LSbit 64
`define rv1_nack_MSbit 64
`define rv1_nack_Sel 64:64
`define rv1_nack_Width 1
`define rv1_nack_LSbit_Addr 8
`define rv1_nack_MSbit_Addr 8
`define rv1_nack_LSbit_Pos 0
`define rv1_nack_MSbit_Pos 0
// Defines for register "rv1_rdata0"
`define rv1_rdata0_LSbit 65
`define rv1_rdata0_MSbit 72
`define rv1_rdata0_Sel 72:65
`define rv1_rdata0_Width 8
`define rv1_rdata0_LSbit_Addr 8
`define rv1_rdata0_MSbit_Addr 9
`define rv1_rdata0_LSbit_Pos 1
`define rv1_rdata0_MSbit_Pos 0
// Defines for register "rv1_rdata1"
`define rv1_rdata1_LSbit 73
`define rv1_rdata1_MSbit 80
`define rv1_rdata1_Sel 80:73
`define rv1_rdata1_Width 8
`define rv1_rdata1_LSbit_Addr 9
`define rv1_rdata1_MSbit_Addr 10
`define rv1_rdata1_LSbit_Pos 1
`define rv1_rdata1_MSbit_Pos 0
// Defines for register "rv1_rdata2"
`define rv1_rdata2_LSbit 81
`define rv1_rdata2_MSbit 88
`define rv1_rdata2_Sel 88:81
`define rv1_rdata2_Width 8
`define rv1_rdata2_LSbit_Addr 10
`define rv1_rdata2_MSbit_Addr 11
`define rv1_rdata2_LSbit_Pos 1
`define rv1_rdata2_MSbit_Pos 0
// Defines for register "rv1_rdata3"
`define rv1_rdata3_LSbit 89
`define rv1_rdata3_MSbit 96
`define rv1_rdata3_Sel 96:89
`define rv1_rdata3_Width 8
`define rv1_rdata3_LSbit_Addr 11
`define rv1_rdata3_MSbit_Addr 12
`define rv1_rdata3_LSbit_Pos 1
`define rv1_rdata3_MSbit_Pos 0
// Field I2C length
`define I2C_field_bit_length 81
`define I2C_field_byte_length 11
