//------------------------------------------------------------------------------
// Basic read and write methods 
//------------------------------------------------------------------------------
//task write(input [6:0] address, input [7:0] data);
//    begin
//        // TODO Implement me - Write address byte (MSb = 0, lower bits are address)
//    end
//endtask
//
//task read(input [6:0] address, output [7:0] data);
//    begin
//        // TODO implement me - Write address byte (MSb = 1, lower bits are address)
//    end
//endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Read all bytes task 
//------------------------------------------------------------------------------
task read_all_bytes(input [6:0] start_address, end_address, output [999:0] data);
    logic [7:0] read_byte;
    begin
        data = '0;
        for (i = 0; i <= (end_address - start_address); i = i + 1) begin
            read(start_address + i, read_byte);
            data[8*i +: 8] = read_byte;
        end
    end
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: LED
//------------------------------------------------------------------------------
// Register: leds
task read_FIELD_LED_REG_leds(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(0, 0, rdata);
        data = {{992{1'b0}}, rdata[7:0]};
    end
endtask

task write_FIELD_LED_REG_leds(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(0, 0, rdata);
        wdata = rdata;
        wdata[7:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(0 + i, wdata[8*i +: 8]);
        end 
    end 
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: RESET
//------------------------------------------------------------------------------
// Register: reset
task read_FIELD_RESET_REG_reset(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(1, 1, rdata);
        data = {{999{1'b0}}, rdata[0:0]};
    end
endtask

task write_FIELD_RESET_REG_reset(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(1, 1, rdata);
        wdata = rdata;
        wdata[0:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(1 + i, wdata[8*i +: 8]);
        end 
    end 
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: I2C
//------------------------------------------------------------------------------
// Register: rv0_valid_pulse
task read_FIELD_I2C_REG_rv0_valid_pulse(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(2, 2, rdata);
        data = {{999{1'b0}}, rdata[0:0]};
    end
endtask

task write_FIELD_I2C_REG_rv0_valid_pulse(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(2, 2, rdata);
        wdata = rdata;
        wdata[0:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(2 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv0_slave_address
task read_FIELD_I2C_REG_rv0_slave_address(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(2, 2, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask

task write_FIELD_I2C_REG_rv0_slave_address(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(2, 2, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(2 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv0_burst_count_wr
task read_FIELD_I2C_REG_rv0_burst_count_wr(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(3, 3, rdata);
        data = {{998{1'b0}}, rdata[1:0]};
    end
endtask

task write_FIELD_I2C_REG_rv0_burst_count_wr(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(3, 3, rdata);
        wdata = rdata;
        wdata[1:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(3 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv0_burst_count_rd
task read_FIELD_I2C_REG_rv0_burst_count_rd(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(3, 3, rdata);
        data = {{998{1'b0}}, rdata[3:2]};
    end
endtask

task write_FIELD_I2C_REG_rv0_burst_count_rd(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(3, 3, rdata);
        wdata = rdata;
        wdata[3:2] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(3 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv0_wdata0
task read_FIELD_I2C_REG_rv0_wdata0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(3, 4, rdata);
        data = {{992{1'b0}}, rdata[11:4]};
    end
endtask

task write_FIELD_I2C_REG_rv0_wdata0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(3, 4, rdata);
        wdata = rdata;
        wdata[11:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(3 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv0_wdata1
task read_FIELD_I2C_REG_rv0_wdata1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(4, 5, rdata);
        data = {{992{1'b0}}, rdata[11:4]};
    end
endtask

task write_FIELD_I2C_REG_rv0_wdata1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(4, 5, rdata);
        wdata = rdata;
        wdata[11:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(4 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv0_wdata2
task read_FIELD_I2C_REG_rv0_wdata2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(5, 6, rdata);
        data = {{992{1'b0}}, rdata[11:4]};
    end
endtask

task write_FIELD_I2C_REG_rv0_wdata2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(5, 6, rdata);
        wdata = rdata;
        wdata[11:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(5 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv0_wdata3
task read_FIELD_I2C_REG_rv0_wdata3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(6, 7, rdata);
        data = {{992{1'b0}}, rdata[11:4]};
    end
endtask

task write_FIELD_I2C_REG_rv0_wdata3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(6, 7, rdata);
        wdata = rdata;
        wdata[11:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(6 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv0_rd_wrn
task read_FIELD_I2C_REG_rv0_rd_wrn(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(7, 7, rdata);
        data = {{999{1'b0}}, rdata[4:4]};
    end
endtask

task write_FIELD_I2C_REG_rv0_rd_wrn(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(7, 7, rdata);
        wdata = rdata;
        wdata[4:4] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(7 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv1_ready
task read_FIELD_I2C_REG_rv1_ready(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(7, 7, rdata);
        data = {{999{1'b0}}, rdata[5:5]};
    end
endtask

task write_FIELD_I2C_REG_rv1_ready(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(7, 7, rdata);
        wdata = rdata;
        wdata[5:5] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(7 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv0_ready
task read_FIELD_I2C_REG_rv0_ready(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(7, 7, rdata);
        data = {{999{1'b0}}, rdata[6:6]};
    end
endtask

task write_FIELD_I2C_REG_rv0_ready(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(7, 7, rdata);
        wdata = rdata;
        wdata[6:6] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(7 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv1_valid
task read_FIELD_I2C_REG_rv1_valid(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(7, 7, rdata);
        data = {{999{1'b0}}, rdata[7:7]};
    end
endtask

task write_FIELD_I2C_REG_rv1_valid(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(7, 7, rdata);
        wdata = rdata;
        wdata[7:7] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(7 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv1_nack
task read_FIELD_I2C_REG_rv1_nack(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(8, 8, rdata);
        data = {{999{1'b0}}, rdata[0:0]};
    end
endtask

task write_FIELD_I2C_REG_rv1_nack(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(8, 8, rdata);
        wdata = rdata;
        wdata[0:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(8 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv1_rdata0
task read_FIELD_I2C_REG_rv1_rdata0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(8, 9, rdata);
        data = {{992{1'b0}}, rdata[8:1]};
    end
endtask

task write_FIELD_I2C_REG_rv1_rdata0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(8, 9, rdata);
        wdata = rdata;
        wdata[8:1] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(8 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv1_rdata1
task read_FIELD_I2C_REG_rv1_rdata1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(9, 10, rdata);
        data = {{992{1'b0}}, rdata[8:1]};
    end
endtask

task write_FIELD_I2C_REG_rv1_rdata1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(9, 10, rdata);
        wdata = rdata;
        wdata[8:1] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(9 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv1_rdata2
task read_FIELD_I2C_REG_rv1_rdata2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(10, 11, rdata);
        data = {{992{1'b0}}, rdata[8:1]};
    end
endtask

task write_FIELD_I2C_REG_rv1_rdata2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(10, 11, rdata);
        wdata = rdata;
        wdata[8:1] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(10 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: rv1_rdata3
task read_FIELD_I2C_REG_rv1_rdata3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(11, 12, rdata);
        data = {{992{1'b0}}, rdata[8:1]};
    end
endtask

task write_FIELD_I2C_REG_rv1_rdata3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(11, 12, rdata);
        wdata = rdata;
        wdata[8:1] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(11 + i, wdata[8*i +: 8]);
        end 
    end 
endtask
//------------------------------------------------------------------------------

