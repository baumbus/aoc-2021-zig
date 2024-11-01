const std = @import("std");
const example_input = @embedFile("./../aoc/day_one/example.txt");
const challenge_input = @embedFile("./../aoc/day_one/challenge.txt");

const ParseError = error{
    EmptyInput,
};

fn print_example_input() !void {
    std.debug.print("{s}\n", .{example_input});
    std.debug.print("\n", .{});

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    var list = std.ArrayList(u8).init(allocator);
    defer list.deinit();

    for (example_input) |byte| {
        try list.append(byte);
    }

    for (example_input) |byte| {
        std.debug.print("{}\n", .{byte});
    }
}

fn print_challenge_input() !void {
    std.debug.print("{s}\n", .{example_input});
}

fn parse_input(input: std.ArrayList(u8), allocator: std.mem.Allocator) ![]i32 {
    if (input.items.len == 0) {
        return ParseError.EmptyInput;
    }
    var list = std.ArrayList(i32).init(allocator);
    defer list.deinit();

    var start: usize = 0;
    var end: usize = 0;

    while (@as(i128, input.items.len) != @as(i128, end) + 1) {
        if (input.items[end] == 0x0A) {
            const result = try std.fmt.parseInt(i32, input.items[start..end], 10);
            try list.append(result);
            start = end + 1;
            end = start;
        }
        end += 1;
    }

    const result = try std.fmt.parseInt(i32, input.items[start..], 10);
    try list.append(result);

    return list.toOwnedSlice();
}

fn solve_challenge_part_one(input: []i32, allocator: std.mem.Allocator) !i32 {
    defer allocator.free(input);

    var current: usize = 0;
    var next: usize = 1;
    var count: u16 = 0;

    while (input.len > next) {
        if (input[current] < input[next]) {
            count += 1;
        }

        std.debug.print("Current: {} Next: {} Check: {} Count: {}\n", .{ input[current], input[next], input[current] < input[next], count });

        current += 1;
        next += 1;
    }

    return count;
}

pub fn solve_part_one(allocator: std.mem.Allocator) !i32 {
    var list = std.ArrayList(u8).init(allocator);
    defer list.deinit();

    for (challenge_input) |byte| {
        try list.append(byte);
    }

    const parsed_input = try parse_input(list, allocator);
    const result = try solve_challenge_part_one(parsed_input, allocator);

    return result;
}

test "exampleInput" {
    const expected = 7;
    const allocator = std.testing.allocator;

    var list = std.ArrayList(u8).init(allocator);
    defer list.deinit();

    for (example_input) |byte| {
        try list.append(byte);
    }

    const parsed_input = try parse_input(list, allocator);
    const result = try solve_challenge(parsed_input, allocator);

    try std.testing.expectEqual(expected, result);
}
