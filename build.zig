const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Add an executable
    const exe = b.addExecutable(.{
        .name = "learningsdl",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Link SDL2 and libC
    exe.linkLibC();
    exe.linkSystemLibrary("SDL2");

    // Install the executable
    b.installArtifact(exe);

    // Create a run step
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    // Allow passing arguments to the executable
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // Add a "run" step to the build system
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
