# Suprima ASRA Zsh Theme

An enhanced, performance-optimized Zsh theme for dark backgrounds, based on the [Ultima Zsh Theme](https://github.com/egorlem/ultima.zsh-theme) by Egor Lem. Suprima ASRA adds modern features, better error/status handling, and improved visuals for developers who want both aesthetics and functionality.

## ✨ Features

### 🎨 Visual Design

<img width="856" height="524" alt="sample" src="https://github.com/user-attachments/assets/f36016f9-a062-4732-8aa9-0a1edd280a45" />


- Minimal, clean interface with Unicode box-drawing and arrow characters
- Optimized for dark backgrounds and modern terminals
- Color-coded segments for status, VCS, and system info
- Full-width separator line for prompt clarity

### 🔧 Version Control & Project Awareness

- **Multi-VCS support:** Git, SVN, Mercurial (configurable)
- **Git enhancements:**
  - Real-time status: staged (A, green), modified (M, cyan), untracked (U, blue)
  - Branch name and short hash display
  - Action status (rebase, merge, etc.)
  - Ahead/behind remote tracking
  - Git stash count and untracked file indicator
- **Project context detection:**
  - Python venv/conda environment name
  - Node.js version (if project detected)
  - Rust and Go version (if project detected)
  - Docker context (🐳 icon, running containers)

### 🖥️ System & Shell Information

- SSH connection indicator (green "SSH:")
- Battery status (Linux/macOS/WSL):
  - 🔋 Green (>80%), Yellow (50-80%), Orange (20-50%), Red (<20%)
  - ⚡ Charging indicator
- System load and memory usage indicators
- Command execution timing (color-coded by duration)
- Exit status with icon and code for failed commands
- Current time (24h, yellow)
- Username and working directory info

### 🎯 Enhanced Shell Experience

- Intelligent, color-coded tab completion with caching
- Custom `LS_COLORS` and `LSCOLORS` for file type highlighting
- Enhanced LESS/MAN page viewing with color support
- Case-insensitive, menu-based completion
- Performance optimizations for large projects

## 🛠️ Installation

### Oh My Zsh

1. Download the theme:

   ```zsh
   curl -o ~/.oh-my-zsh/themes/suprima-asra.zsh-theme \
     https://raw.githubusercontent.com/mohdismailmatasin/suprima-asra/main/suprima-asra.zsh-theme
   ```

2. Set in your `~/.zshrc`:

   ```zsh
   ZSH_THEME="suprima-asra"
   ```

3. Reload your shell:

   ```zsh
   source ~/.zshrc
   ```

## 📋 Requirements

- **Zsh** 5.0+
- **Git** (for VCS features)
- **Terminal** with Unicode & 256 color support
- **Font** with Unicode glyphs

### Optional (for extra features)

- **Node.js** (for Node version display)
- **Python** (for venv/conda detection)
- **Rust** (for Rust version display)
- **Go** (for Go version display)
- **Docker** (for Docker context)
- **Battery info** (Linux: `/sys/class/power_supply/BAT0`, macOS: `pmset`, WSL: `powershell.exe`)

## 🎛️ Configuration & Customization

### VCS Support

By default, Git is enabled. To change or disable VCS:

```zsh
export VCS="git"    # Options: "git", "svn", "hg", or "" to disable
```

### Customizing Colors

Colors are set for optimal contrast on dark backgrounds. You can edit color codes in the theme file (see comments for each segment).

### Timing Threshold

To change the command execution time color thresholds, edit the `cmd_exec_time` function in the theme file.

## 📱 Prompt Layout

### Left Prompt (PS1)

```zsh
┌────────────────────────────────────────────────────────────
└ SSH: (username) on ~/current/path › branch-name
  ›
```

### Right Prompt (RPROMPT)

```zsh
⏱ 7s | 📊 1.2 | 🧠 65% | ⎈ context | 🐳[2] | 🦀 1.70 | 🐹 1.21 | ⬢ 18.0.0 | 🐍 venv | ✗ 1 | 14:30:25 | 🔋 85%
```

*Segments only appear if relevant (e.g., Docker, Rust, Go, Node, Python, Kubernetes, etc.)*

### Secondary Prompts

- **PS2**: Continuation prompt for multi-line commands
- **PS3**: Selection prompt for `select` statements

## 🎨 Color Scheme

- **Directories:** Cyan
- **Git branches:** Green
- **Modified files:** Cyan
- **Untracked files:** Blue
- **Staged files:** Green
- **Error indicators:** Red
- **Time/Battery:** Yellow
- **Username:** Gray
- **SSH indicator:** Green

## 🔧 Advanced Features

### Completion System

- Cached completions for faster performance
- Color-coded completion menus
- Case-insensitive matching
- SSH host completion from known_hosts
- File type awareness with ignored patterns

### Terminal Enhancements

- Enhanced LESS pager with syntax highlighting
- Improved MAN pages with color support
- Smart file listing with LS_COLORS
- History optimization

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📜 License

This project is licensed under the same terms as the original Ultima theme.

## 🙏 Acknowledgments

- **Egor Lem** - Original [Ultima theme](https://github.com/egorlem/ultima.zsh-theme) creator
- **Zsh community** - For the excellent shell and plugin ecosystem

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/mohdismailmatasin/suprima-asra/issues) page
2. Create a new issue with details (system info, zsh version, screenshot if possible)

---

Made with ❤️ for developers who appreciate both functionality and aesthetics
