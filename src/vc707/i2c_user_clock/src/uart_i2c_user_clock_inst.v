
/***************************************************/
/* Instantiate Module: uart_i2c_user_clock_mem_map */
/***************************************************/
uart_i2c_user_clock_mem_map uart_i2c_user_clock_instance
(
.uart_i2c_user_clock_write_mem(uart_i2c_user_clock_write_mem),
.uart_i2c_user_clock_read_mem(uart_i2c_user_clock_read_mem),
.leds(leds),
.reset(reset),
.rv0_valid_pulse(rv0_valid_pulse),
.rv0_ready(rv0_ready),
.rv0_slave_address(rv0_slave_address),
.rv0_burst_count_wr(rv0_burst_count_wr),
.rv0_burst_count_rd(rv0_burst_count_rd),
.rv0_wdata0(rv0_wdata0),
.rv0_wdata1(rv0_wdata1),
.rv0_wdata2(rv0_wdata2),
.rv0_wdata3(rv0_wdata3),
.rv0_rd_wrn(rv0_rd_wrn),
.rv1_valid(rv1_valid),
.rv1_ready(rv1_ready),
.rv1_rdata0(rv1_rdata0),
.rv1_rdata1(rv1_rdata1),
.rv1_rdata2(rv1_rdata2),
.rv1_rdata3(rv1_rdata3)
);

/*********************/
/* Wire Declarations */
/*********************/
wire [7:0] uart_i2c_user_clock_write_mem [127:0];
wire [7:0] uart_i2c_user_clock_read_mem [127:0];
wire [7:0] leds;
wire reset;
wire rv0_valid_pulse;
wire [6:0] rv0_slave_address;
wire [1:0] rv0_burst_count_wr;
wire [1:0] rv0_burst_count_rd;
wire [7:0] rv0_wdata0;
wire [7:0] rv0_wdata1;
wire [7:0] rv0_wdata2;
wire [7:0] rv0_wdata3;
wire rv0_rd_wrn;
wire rv1_ready;
wire rv0_ready;
wire rv1_valid;
wire [7:0] rv1_rdata0;
wire [7:0] rv1_rdata1;
wire [7:0] rv1_rdata2;
wire [7:0] rv1_rdata3;
