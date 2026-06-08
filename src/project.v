`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs - data_in
    output wire [7:0] uo_out,   // Dedicated outputs - accum_out lower byte
    input  wire [7:0] uio_in,   // IOs: Input path - weight_in
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path
    input  wire       ena,      // always 1 when design is powered
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Pin configurations mapping to structural signals
    wire [7:0] data_in   = ui_in;
    wire [7:0] weight_in = uio_in;
    
    wire is_data_zero   = (data_in == 8'b0);
    wire is_weight_zero = (weight_in == 8'b0);
    wire skip_cond      = is_data_zero || is_weight_zero;

    reg [15:0] accum_out;
    reg        skipped_flag;

    // Output routing configurations
    assign uio_oe  = 8'b00000000; // Bidirectional lines set as inputs for weights
    assign uio_out = 8'b00000000;
    assign uo_out  = accum_out[7:0]; // Loading output byte format arrays

    // List all unused inputs to prevent warnings
    wire _unused = &{ena, 1'b0};

    // Physical Design logic block
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            accum_out    <= 16'b0;
            skipped_flag <= 1'b0;
        end else begin
            if (skip_cond) begin
                accum_out    <= accum_out; // Skip execution tracking bounds
                skipped_flag <= 1'b1;
            end else begin
                accum_out    <= accum_out + (data_in * weight_in);
                skipped_flag <= 1'b0;
            end
        end
    end

endmodule
