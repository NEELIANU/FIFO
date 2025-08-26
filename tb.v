`include "fifo.v"
module tb;

  // Parameters
  parameter DATA_WIDTH = 16;
  parameter DEPTH = 16;
  parameter PTR_WIDTH = 4;

  // Testbench signals
  reg clk, rst, wr_en, rd_en;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;
  wire full, empty;

  // Instantiate the FIFO
  fifo #(DATA_WIDTH, DEPTH, PTR_WIDTH) dut (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
  );

  // Clock generator
  always #5 clk = ~clk;  // 100MHz clock

  initial begin
    // Initialize
    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;

    // Reset FIFO
    #10;
    rst = 0;

    // Write 5 values
    $display("Writing to FIFO:");
    repeat (5) begin
      @(posedge clk);
      wr_en = 1;
      data_in = data_in + 1;
      $display("  Wrote: %d", data_in);
    end
    wr_en = 0;

    // Wait a bit
    #10;

    // Read 5 values
    $display("Reading from FIFO:");
    repeat (5) begin
      @(posedge clk);
      rd_en = 1;
      $display("  Read: %d", data_out);
    end
    rd_en = 0;

    // Finish simulation
    #20;
    $finish;
  end

endmodule

