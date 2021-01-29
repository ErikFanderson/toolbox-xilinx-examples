module blink (clk_p, clk_n, led);

input clk_p;
input clk_n;
output led;

// Convert LVDS clock to internal clock signal
IBUFGDS #(
    .DIFF_TERM("FALSE"), // Differential termination
    .IBUF_LOW_PWR("TRUE"), // Low power="TRUE", High performance="FALSE"
    .IOSTANDARD("DEFAULT") // Specify input IO standard
) IBUFGDS_inst (
    .O(clk_buf), // Clock output buffer
    .I(clk_p), // Diff_p clock buffer input (connect directly to top-level port)
    .IB(clk_n) // Diff_n clock buffer input (connect directly to top-level port)
);

reg [31:0] counter;
reg led_status;

initial begin
    counter <= 32'b0;
    led_status <= 1'b1;
end

always @ (posedge clk_buf) begin
    counter <= counter + 1'b1;
    if (counter > 50000000) begin
        led_status <= !led_status;
        counter <= 32'b0;
    end
end

assign led = led_status;

endmodule 
