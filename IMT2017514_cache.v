// This is the implementation of the cache which stores the data and the size is currently 256 blocks.
`define _SIZE 31
`define _INDEX 4
`define _TAG 22
module cache(instruction, clk, signal);
    // The input for the cache module is 32 bit instruction.
    input [31:0]instruction;
    input clk;
    // The output generated by the cache module is a signal which represents whether the data of the given address is present or not.
    output reg signal;

    // This is where the cache is stored.
    reg [`_TAG+1:0] cache_memory [0:`_SIZE];

    // Here the instruction is split into it's respective categories which are the tag, index and offset.  
    wire [`_TAG:0] tag;
    wire [`_INDEX:0] index;
    wire [3:0] offset;

    // This is where they are assigned the values.
    assign offset = instruction[3:0];
    assign index = instruction[11:4];
    assign tag = instruction[31:12];

    always@(posedge clk)
    begin: loop_block
       if(cache_memory[index][`_TAG+1]) // if valid bit is set i.e. data is present
       begin
        if(tag == cache_memory[index][`_TAG:0])
        begin
          signal <= 1; //Here the signal is assgined based on the given criteria which is the at the index the tag should be equal to that of the instruction.
          disable loop_block;
        end
        else
        begin
          cache_memory[index][`_TAG:0] <= tag; // When the tags are not the same, we overwrite the previous data with new data.
          signal <= 0;
          disable loop_block;
        end
      end
      else
      begin
        signal <= 0; // When the valid bit is zero at the index of the cache.
        cache_memory[index][`_TAG:0] <= tag;
        cache_memory[index][`_TAG+1] <= 1; // storing new data at that index and setting valid bit
        disable loop_block;
      end
    end
endmodule
