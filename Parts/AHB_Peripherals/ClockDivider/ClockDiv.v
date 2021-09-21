//  --========================================================================--
//  Version and Release Control Information:
//
//  File Name           : ClockDiv.v
//  File Revision       : 1.00
//
//  ----------------------------------------------------------------------------
//  Purpose             : Platform specific Clock Divider
//                        
//  --========================================================================--


module ClockDiv(
	//Clock Input
			input wire 	CLK_I,
	//Clock Output
			output wire CLK_O

    );

//	always @ (posedge CLK_I)
//		begin
//			CLK_O <= !CLK_O;
//		end

	assign CLK_O = CLK_I;

endmodule
