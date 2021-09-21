module AHB7SEG(
	//AHBLITE INTERFACE
		//Slave Select Signals
			input wire HSEL,
		//Global Signal
			input wire HCLK,
			input wire HRESETn,
		//Address, Control & Write Data
			input wire HREADY,
			input wire [31:0] HADDR,
			input wire [1:0] HTRANS,
			input wire HWRITE,
			input wire [2:0] HSIZE,
			input wire [31:0] HWDATA,
		// Transfer Response & Read Data
			output wire HREADYOUT,
			output wire [31:0] HRDATA,
		//LED Output
			output wire [6:0] HEX0,
			output wire [6:0] HEX1,
			output wire [6:0] HEX2,
			output wire [6:0] HEX3,
			output wire [6:0] HEX4,
			output wire [6:0] HEX5,
			output wire [6:0] HEX6,
			output wire [6:0] HEX7
);

//Address Phase Sampling Registers
  reg rHSEL;
  reg [31:0] rHADDR;
  reg [1:0] rHTRANS;
  reg rHWRITE;
  reg [2:0] rHSIZE;
  reg [31:0] rLED;

//Address Phase Sampling
  always @(posedge HCLK or negedge HRESETn)
	begin
		if(!HRESETn)
			begin
				rHSEL		<= 1'b0;
				rHADDR	<= 32'h0;
				rHTRANS	<= 2'b00;
				rHWRITE	<= 1'b0;
				rHSIZE	<= 3'b000;
			end
		else if(HREADY)
			begin
				rHSEL		<= HSEL;
				rHADDR	<= HADDR;
				rHTRANS	<= HTRANS;
				rHWRITE	<= HWRITE;
				rHSIZE	<= HSIZE;
			end
	end

//Data Phase data transfer
  always @(posedge HCLK or negedge HRESETn)
	begin
		if(!HRESETn)
			rLED <= 32'b0000_0000;
		else if(rHSEL & rHWRITE & rHTRANS[1])
			rLED <= HWDATA[31:0];
	end

	
	// Decode the bytes lanes depending on HSIZE & HADDR[1:0]

  wire tx_byte = ~rHSIZE[1] & ~rHSIZE[0];
  wire tx_half = ~rHSIZE[1] &  rHSIZE[0];
  wire tx_word =  rHSIZE[1];
  
  wire byte_at_00 = tx_byte & ~rHADDR[1] & ~rHADDR[0];
  wire byte_at_01 = tx_byte & ~rHADDR[1] &  rHADDR[0];
  wire byte_at_10 = tx_byte &  rHADDR[1] & ~rHADDR[0];
  wire byte_at_11 = tx_byte &  rHADDR[1] &  rHADDR[0];
  
  wire half_at_00 = tx_half & ~rHADDR[1];
  wire half_at_10 = tx_half &  rHADDR[1];
  
  wire word_at_00 = tx_word;
  
  wire byte0 = word_at_00 | half_at_00 | byte_at_00;
  wire byte1 = word_at_00 | half_at_00 | byte_at_01;
  wire byte2 = word_at_00 | half_at_10 | byte_at_10;
  wire byte3 = word_at_00 | half_at_10 | byte_at_11;

// Writing to the memory

  always @(posedge HCLK)
  begin
	 if(rHSEL & rHWRITE & rHTRANS[1])
	 begin
		if(byte0)
			rLED[7:0] <= HWDATA[7:0];
		if(byte1)
			rLED[15:8] <= HWDATA[15:8];
		if(byte2)
		   rLED[23:16] <= HWDATA[23:16];
		if(byte3)
			rLED[31:24] <= HWDATA[31:24];
	  end
  end
	
//Transfer Response
  assign HREADYOUT = 1'b1; //Single cycle Write & Read. Zero Wait state operations

//Read Data  
  assign HRDATA = rLED;
//  assign LED = rLED;
 
hexto7segment hex0(rLED[3:0], HEX0 [6:0]);  
hexto7segment hex1(rLED[7:4], HEX1 [6:0]);
hexto7segment hex2(rLED[11:8], HEX2 [6:0]);
hexto7segment hex3(rLED[15:12], HEX3 [6:0]);
hexto7segment hex4(rLED[19:16], HEX4 [6:0]);
hexto7segment hex5(rLED[23:20], HEX5 [6:0]);
hexto7segment hex6(rLED[27:24], HEX6 [6:0]);
hexto7segment hex7(rLED[31:28], HEX7 [6:0]);


endmodule

