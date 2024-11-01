const std = @import("std");
const testing = std.testing;
const day_one = @import("days/day_one.zig");

pub fn execute() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    const day_one_part_one = try day_one.solve_part_one(allocator);

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Advent of Code 2023\n", .{});
    try stdout.print("-------------------\n", .{});
    try stdout.print("Day 1.1 - {}\n", .{day_one_part_one});

    try bw.flush();
}
