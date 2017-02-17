// -----------------------------------------------------------------------------
// FILE NAME      :	Wu_Manber_register.v
// DEPARTMENT     : Computer Engineering
// AUTHOR         : Ashik Poojari
// -----------------------------------------------------------------------------
// RELEASE HISTORY
// VERSION DATE        AUTHOR  DESCRIPTION
// 1.0     2016-09-18  Ashik Poojari       
// -----------------------------------------------------------------------------
// KEYWORDS    : General file searching keywords, leave blank if none.
// -----------------------------------------------------------------------------
// PURPOSE     : Short description of functionality
// -----------------------------------------------------------------------------
// PARAMETERS
//     PARAM NAME      RANGE    : DESCRIPTION       : DEFAULT : UNITS
// e.g.DATA_WIDTH     [32,16]   : width of the data : 32      :
// -----------------------------------------------------------------------------
// REUSE ISSUES
//   Reset Strategy        : Asynchronous
//   Clock Domains         :
//   Critical Timing       :
//   Test Features         :
//   Asynchronous I/F      :
//   Scan Methodology      :
//   Instantiations        :
//   Synthesizable (y/n)   : y
//   Other                 :
// -FHDR------------------------------------------------------------------------
`timescale 100ns/1ns
module register #(parameter WIDTH=8)
		(input clk,
		 input reset,
		 input xclear,
		 input xload,
		 input [WIDTH-1:0] xin,
		 output reg [WIDTH-1:0] xout);


always @ (posedge clk) begin
	if(xclear || reset)
		xout <= 0;
	else if(xload) begin
			xout <= xin;
	end
end

endmodule