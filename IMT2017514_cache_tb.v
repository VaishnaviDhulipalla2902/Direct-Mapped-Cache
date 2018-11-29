`timescale 1ns/1ps
module cache_tb;
    reg[31:0] instruction;
    reg clk;
    wire hit;

    integer file_open, file_scan; // These are file variables to open and access contents of a file.
    reg[31:0] temp;

    reg[31:0] hit_count = 0, miss_count = 0; // These are the total number of hits and misses, used to calculate the hit rate and plot the graph.
    

    main uut(.instruction(instruction), .clk(clk), .hit(hit)); // Unit Under Test

    initial begin
      $dumpfile("cache_out.vcd");
      $dumpvars(0, cache_tb);
      clk = 0;
      file_open = $fopen("t5.txt", "r"); // Open file in read mode
      while(!$feof(file_open)) // Scan till end of file
      begin
        file_scan = $fscanf(file_open, "%b\n", temp); // Read each line i.e. 32 bit instruction
        instruction = temp;
        #10;
      end
      #10 $finish;
    end

    always begin
      #5 clk = ~clk;
      if(clk == 1 && hit == 1) // If output signal for a particular instruction is a hit
        hit_count = hit_count + 1;
      if(clk == 1 && hit == 0) // If output signal is a miss
        miss_count = miss_count + 1;
    end
    initial begin
      $display(" hitCount     missCount");
      $monitor(hit_count,"   ",miss_count);
    end
endmodule
