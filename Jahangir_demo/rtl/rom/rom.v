/*
written by Yuyang Zhou
used for jahangir processor
rom to store the instructure
output the corresponding instruction according to its input address
*/
module rom(
	input     	  [31:0]              pc,
	input      	                      ce,
	output  reg   [31:0]              inst	
);

//define a register array to store the instruction
//the size(capacity) of the rom is 128 kb, thus 131071 bytes
reg     [31:0]   rom [0:131070];

//set the data in the rom according to the data file
initial  $readmemh("rom.data",rom);
//logic of the rom, output instruction when ce==1'b1
always @(*)begin
	if(ce==1'b0)begin
		inst <= 32'h0000_0000;
	end
	else begin
	//we get 32 bits in one address, but the data are stored in the rom as a 
	//format of byte (8bits a byte) therefore, we divide the address by 4
	//which is right shifting the data for 2 bits
	//the address is actually repressed by a number containing log2(131070) bits
	//thus 17, it would have been 16:0, now due to the right shifting it becomes
	//18:2.
		inst <= rom[pc[18:2]];
	end
end

endmodule
