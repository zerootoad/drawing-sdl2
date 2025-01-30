const c = @cImport({
    @cInclude("SDL.h");
});

const std = @import("std");

pub fn main() !void {
    if (c.SDL_Init(c.SDL_INIT_EVERYTHING) != 0) {
        c.SDL_Log("Unable to initialize SDL: %s", c.SDL_GetError());
        return;
    }
    defer c.SDL_Quit();

    const window = c.SDL_CreateWindow(
        "SDL2 WINDOW GANG!",
        c.SDL_WINDOWPOS_UNDEFINED,
        c.SDL_WINDOWPOS_UNDEFINED,
        800,
        600,
        c.SDL_WINDOW_SHOWN,
    ) orelse {
        c.SDL_Log("Unable to create window: %s", c.SDL_GetError());
        return;
    };
    defer c.SDL_DestroyWindow(window);

    // const win: *c.SDL_Window = undefined;
    // const rend: *c.SDL_Renderer = undefined;
    // const window = c.SDL_CreateWindowAndRenderer(800, 600, null, win, rend) orelse {
    //     c.SDL_Log("Unable to create window and renderer: %s", c.SDL_GetError());
    //     return;
    // };
    // defer c.SDL_DestroyWindow(win);
    // defer c.SDL_DestroyRenderer(rend);

    // const surface = c.SDL_GetWindowSurface(window) orelse {
    //     c.SDL_Log("Unable to get window surface: %s", c.SDL_GetError());
    //     return;
    // };
    // defer c.SDL_FreeSurface(surface);

    // const imagesurface = c.SDL_LoadBMP("src/image.bmp") orelse {
    //     c.SDL_Log("Unable to load image.bmp file: %s", c.SDL_GetError());
    //     return;
    // };
    // defer c.SDL_FreeSurface(imagesurface);

    // _ = c.SDL_FillRect(surface, null, c.SDL_MapRGB(surface.*.format, 0, 0, 0));

    // _ = c.SDL_BlitSurface(imagesurface, null, surface, null);
    // _ = c.SDL_UpdateWindowSurface(window);

    const renderer = c.SDL_CreateRenderer(window, 0, 0) orelse {
        c.SDL_Log("Unable to create renderer: %s", c.SDL_GetError());
        return;
    };
    defer c.SDL_DestroyRenderer(renderer);

    _ = c.SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
    _ = c.SDL_RenderClear(renderer);
    _ = c.SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
    _ = c.SDL_RenderPresent(renderer);

    var event: c.SDL_Event = undefined;
    var running = true;
    var m1hold = false;
    var prevx: i32 = -1;
    var prevy: i32 = -1;

    while (running) {
        while (c.SDL_PollEvent(&event) != 0) {
            switch (event.type) {
                c.SDL_QUIT => running = false,
                c.SDL_KEYDOWN => {
                    switch (event.key.keysym.sym) {
                        c.SDLK_ESCAPE => running = false,
                        c.SDLK_q => {
                            _ = c.SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
                            _ = c.SDL_RenderClear(renderer);
                            _ = c.SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
                            _ = c.SDL_RenderPresent(renderer);
                        },
                        else => {},
                    }
                },
                c.SDL_MOUSEBUTTONDOWN => {
                    switch (event.button.button) {
                        c.SDL_BUTTON_LEFT => {
                            std.debug.print("Holding M1\n", .{});
                            m1hold = true;
                            prevx = event.button.x;
                            prevy = event.button.y;
                        },
                        else => {},
                    }
                },
                c.SDL_MOUSEBUTTONUP => {
                    switch (event.button.button) {
                        c.SDL_BUTTON_LEFT => {
                            std.debug.print("Released M1\n", .{});
                            m1hold = false;
                            prevx = -1;
                            prevy = -1;
                        },
                        else => {},
                    }
                },
                c.SDL_MOUSEMOTION => {
                    if (m1hold and prevx != -1 and prevy != -1) {
                        const x = event.motion.x;
                        const y = event.motion.y;

                        std.debug.print("Drawing at ({};{})\n", .{ x, y });
                        _ = c.SDL_RenderDrawLine(renderer, prevx, prevy, x, y);

                        prevx = x;
                        prevy = y;
                    }
                },
                else => {},
            }
        }

        _ = c.SDL_RenderPresent(renderer);
        c.SDL_Delay(100);
    }
}
