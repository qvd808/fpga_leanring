// Module: Full Addr

module full_addr (
	// Inputs
	input	[2: 0]	pmod,

	// Outputs
	output	  		out,
	output  		carry
);

	// Wire (net) declaration (internal to module)
	wire xor1;
	wire and1;
	wire xor2;
	wire and2;

	// Assign logic to wire
	assign xor1 = ~pmod[0] ^ ~pmod[1];
	assign and1 = ~pmod[0] & ~pmod[1];
	assign xor2 = xor1 ^ ~pmod[2];
	assign and2 = xor1 & ~pmod[2];

	// Assign output to LED
	assign out   = xor2;
	assign carry =  and2 | and1;


endmodule
