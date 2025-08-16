module button_debounce (

    // Inputs
    input       [1:0]   pmod,
    input       		clk,

    // Outputs
    output  reg [3:0]   led
);

    wire rst;
    wire go;

    // Inverse signal
	assign rst = ~pmod[0];
	assign go  = ~pmod[1];

	// States
	// Need 2 bits to store the states
	localparam STATE_IDLE     = 2'd0;
	localparam STATE_PUSH     = 2'd1;
	localparam STATE_DONE     = 2'd2;

	reg [1:0]	 state;
	reg [19:0]   clk_count;

	// State transition
	always @ (posedge clk or posedge rst) begin
		// On reset, return to idle state
		if (rst == 1) begin
			state <= STATE_IDLE;
			led <= 4'd0;
		// Define the state transitions
		end else begin
			case (state)

				STATE_IDLE: begin
					if (go == 1'b1) begin
						state <= STATE_PUSH;
						clk_count <= 0;
					end
				end

				// Go from counting to done if counting reaches max
				STATE_PUSH: begin
					if (go == 1'b0) begin
						state <= STATE_DONE;
						led <= led + 1;
					end
				end

				STATE_DONE: begin
						if (clk_count != 20'd600000) begin
						clk_count <= clk_count + 1;
					end else begin
						clk_count <= 20'b0;
						state <= STATE_IDLE;
					end
				end

				// Go to idle if in unknown state
				default: state <= STATE_IDLE;
			endcase

		end
	end

endmodule
