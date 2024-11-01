const std = @import("std");

pub const lib = @import("root.zig");

pub fn main() !void {
    try lib.execute();
}

test "unit tests" {
    std.testing.refAllDeclsRecursive(@This());
}
