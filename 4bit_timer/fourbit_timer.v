// Clock-divided counter
//
// Inputs:  
//      clk         - 12 MHz clock
//      
// Outputs:
//      led[3:0]    - LEDs (count from 0x0 to 0xf)
//
// LEDs will display a binary number that increments by one each second.
//
// Date: October 26, 2021
// Author: Shawn Hymel
// License: 0BSD

// Count up each second
module fourbit_timer (

    // Inputs
    input               clk,
    
    // Outputs
    output  reg [3:0]   led
);

    reg div_clk;
    reg [31:0] count;
    localparam [31:0] max_count = 6000000 - 1;

    // Count up on (divided) clock rising edge or reset on button push
    always @ (posedge div_clk) begin
		led <= led + 1'b1;
    end
    
    // Clock divider
    always @ (posedge clk) begin
        if (count == max_count) begin
            count <= 32'b0;
            div_clk <= ~div_clk;
        end else begin
            count <= count + 1;
        end
    end
    
endmodule
