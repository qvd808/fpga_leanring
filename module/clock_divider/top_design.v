// Top level design that produces 2 different divied clocks

module top_design (

    // Inputs
    input        clk,
    input        rst_btn,
    // Outputs
    output [1:0] led
);

  wire rst;
  assign rst = ~rst_btn;


  // Instaiate the first clock divider
  clock_divider #(
      .COUNT_WIDTH(32),
      .MAX_COUNT  (1500000 - 1)
  ) div_1 (
      .clk(clk),
      .rst(rst),
      .out(led[0])
  );

  // Parameters - oldways
  // defparam div_1.COUNT_WIDTH = 32; defparam div_1.MAX_COUNT = 1500000 - 1;

  clock_divider div_2 (
      .clk(clk),
      .rst(rst),
      .out(led[1])
  );

endmodule
