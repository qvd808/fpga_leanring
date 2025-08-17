// Mealy state machine that counts when go signal is sent
module counter_fsm #(

    // Parameters
    parameter COUNT_UP  = 1'b1,  // 1'b1 to count up
    parameter MAX_COUNT = 4'hF   // Maximum number to count to
) (

    // Inputs
    input clk,
    input rst,
    input go,

    // Outputs
    output reg [3:0] out,
    output reg       done
);

  // States
  localparam STATE_IDLE = 1'd0;
  localparam STATE_COUNTING = 1'd1;

  // Internal storage elements
  reg state;

  // State transition logic
  always @(posedge clk or posedge rst) begin

    // On reset, return to idle state
    if (rst == 1'b1) begin
      state <= STATE_IDLE;

      // Define the state transitions
    end else begin
      case (state)

        // Wait for go signal
        STATE_IDLE: begin
          done <= 1'b0;
          if (go == 1'b1) begin
            state <= STATE_COUNTING;
          end
        end

        // Go from counting to done if counting reaches max
        STATE_COUNTING: begin
          if (COUNT_UP == 1'b1 && out == MAX_COUNT) begin
            done  <= 1'b1;
            state <= STATE_IDLE;
          end else if (COUNT_UP == 1'b0 && out == 0) begin
            done  <= 1'b1;
            state <= STATE_IDLE;
          end
        end

        // Go to idle if in unknown state
        default: state <= STATE_IDLE;
      endcase
    end
  end

  // Handle the counter output
  always @(posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
      out <= 4'd0;
    end else begin
      case (state)

        // Start counter at the right value
        STATE_IDLE: begin
          if (COUNT_UP == 1'b1) begin
            out <= 4'd0;
          end else begin
            out <= MAX_COUNT;
          end
        end

        // Count up or down
        STATE_COUNTING: begin
          if (COUNT_UP == 1'b1) begin
            if (out != MAX_COUNT) out <= out + 1;
          end else begin
            if (out != 4'h0) out <= out - 1;
          end
        end

        default: out <= out;
      endcase
    end
  end

endmodule
