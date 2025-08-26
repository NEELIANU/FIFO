/*module fifo(clk,rst,wr_en,rd_en,data_in,data_out,empty,full);
parameter DATA_WIDTH=16,DEPTH=16,PTR_WIDTH=4;
input clk,rst,wr_en,rd_en;
input [DATA_WIDTH-1:0]data_in;
output  full,empty;
output reg [DATA_WIDTH-1:0]data_out;
reg[DATA_WIDTH-1:0]mem[DEPTH-1:0];
reg[PTR_WIDTH-1:0]rd_ptr,wr_ptr;
reg[DATA_WIDTH-1:0]i;
assign full=(wr_ptr==4'd16?1'b1:1'b0);
assign empty=(rd_ptr==4'd16?1'b1:1'b0);
always@(posedge clk,posedge rst)
begin
if(rst)
begin
data_out<=16'd0;
full<=1'b0;
empty<=1'b0;
wr_ptr<=4'd0;
rd_ptr<=4'd0;
i<=4'd0;
for(i=0;i<16;i=i+1)
mem[i]<=16'd0;
end
else
if(wr_ptr==1'b1 && full=1'b0)
begin
mem[wr_ptr]<=data_in;
wr_ptr<=wr_ptr+1;
end
else if(rd_ptr==1'b1 && empty=1'b0)
begin
data_out<=mem[rd_ptr];
rd_ptr<=rd_ptr+1;
end
end
endmodule*/



module fifo #(parameter DATA_WIDTH = 16, DEPTH = 16, PTR_WIDTH = 4)(
  input clk,
  input rst,
  input wr_en,
  input rd_en,
  input [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out,
  output reg full,
  output reg empty
);

  reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
  reg [PTR_WIDTH-1:0] wr_ptr, rd_ptr;
  reg [PTR_WIDTH:0] count;  // To track number of stored elements
  integer i;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      wr_ptr <= 0;
      rd_ptr <= 0;
      data_out <= 0;
      full <= 0;
      empty <= 1;
      count <= 0;
      for (i = 0; i < DEPTH; i = i + 1)
        mem[i] <= 0;
    end else begin
      // Write operation
      if (wr_en && !full) begin
        mem[wr_ptr] <= data_in;
        wr_ptr <= wr_ptr + 1;
        count <= count + 1;
      end

      // Read operation
      if (rd_en && !empty) begin
        data_out <= mem[rd_ptr];
        rd_ptr <= rd_ptr + 1;
        count <= count - 1;
      end

      // Update full and empty
      full <= (count == DEPTH);
      empty <= (count == 0);
    end
  end

endmodule
