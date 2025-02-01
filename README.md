# Drawing-SDL2 (SDL3: [click me](https://github.com/zerootoad/drawing-sdl3/))
A simple drawing application using SDL2 in Zig.

This project can also serve as a template for SDL2-based Zig projects.

![Screenshot](https://github.com/user-attachments/assets/b0847104-7a60-4c2b-84aa-429557a9a90b)

---

## Prerequisites
Before running the application, ensure you have the following installed:

### SDL2 Setup
Install the SDL2 dependencies for your operating system:

- **Arch Linux**:  
  ```bash
  sudo pacman -S sdl2
  ```

- **Debian/Ubuntu**:  
  ```bash
  sudo apt install libsdl2-dev
  ```

- **Fedora**:  
  ```bash
  sudo dnf install SDL2-devel
  ```

- **macOS (Homebrew)**:  
  ```bash
  brew install sdl2
  ```

- **Windows**:  
  Download prebuilt binaries from the [SDL2 GitHub releases page](https://github.com/libsdl-org/SDL/releases).

### Zig
Ensure you have Zig installed. You can download it from the [official Zig website](https://ziglang.org/download/).

---

## Running the Application
1. Clone this repository:
   ```bash
   git clone https://github.com/zerootoad/drawing-sdl2.git
   cd drawing-sdl2
   ```

2. Build and run the project:
   ```bash
   zig build run
   ```

---

## Features
- Draw on the screen using the mouse.
- Clear the screen with a button or keypress.
- Simple and lightweight implementation.

---

## Project Structure
```
drawing-sdl2/
├── src/
│   └── main.zig       # Main application logic
├── build.zig          # Zig build script
└── README.md          # This file
```

---

## Contributing
Contributions are welcome! Feel free to open an issue or submit a pull request.
