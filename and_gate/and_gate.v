// Module: button 0 lights up 2 LEDs, button 0 and 1 light up another

module and_gate (
	// Inputs
	input	[1: 0]	pmod,

	// Outpus
	output	[2: 0]	led
);

	// Wire (net) declaration (internal to module)
	wire not_pmod_0;

	// Continous assignment: REplicate 1 wire to 2 outputs
	assign not_pmod_0 = ~pmod[0];
	assign led[1:0] = {2{not_pmod_0}};
	
	// Continous assignment: NOT and AND operator
	assign led[2] = not_pmod_0 & ~pmod[1];

endmodule
