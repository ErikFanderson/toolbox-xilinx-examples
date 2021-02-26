
/****************************************/
/* Instantiate Module: uart_led_mem_map */
/****************************************/
uart_led_mem_map uart_led_instance
(
.uart_led_write_mem(uart_led_write_mem),
.uart_led_read_mem(uart_led_read_mem),
.leds0(leds0),
.leds1(leds1),
.reset(reset)
);

/*********************/
/* Wire Declarations */
/*********************/
wire [7:0] uart_led_write_mem [127:0];
wire [7:0] uart_led_read_mem [127:0];
wire [3:0] leds0;
wire [3:0] leds1;
wire reset;
