module hexto7segment (
     input  [3:0]x,
	  output reg[6:0]z
	  );
	  
	 
	  always@*
	  case(x)
	  4'b0010 :            //Hexadecimal 2
	       z = 7'b0000010;
	  4'b0000 :            //Hexadecimal 0
	       z = 7'b0000000;	 
	  4'b0001 :            //Hexadecimal 1
	       z = 7'b0000001;	
	  4'b0101 :            //Hexadecimal 5
	       z = 7'b0000101;	
	  4'b0010 :            //Hexadecimal 2
	       z = 7'b0000010;
	  4'b0111 :            //Hexadecimal 7
	       z = 7'b0000111;
	  4'b1001 :            //Hexadecimal 9
	       z = 7'b0001001;	
	  4'b0100 :            //Hexadecimal 4
	       z = 7'b0000100;	
	   4'b1001 :            //Hexadecimal 9
	       z = 7'b0001001;
	   default :           //default
          z = 7'bxxxxxxx;		

endcase	
	
	endmodule		