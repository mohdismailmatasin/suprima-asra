# Suprima ASRA Zsh Theme

An enhanced Zsh theme optimized for dark terminal backgrounds with performance improvements, additional features, and better error handling.

![Suprima ASRA Theme Preview](https://via.placeholder.com/800x400/0d1117/ffffff?text=Suprima+ASRA+Zsh+Theme+Preview)

## ✨ Features

- **Dark Background Optimized**: Specifically designed for dark terminals with enhanced color contrast
- **Performance Optimized**: Faster prompt rendering with caching mechanisms
- **Rich Information Display**: Shows git status, battery level, system load, memory usage, and more
- **Multi-language Environment Support**: Displays status for Python, Node.js, Rust, Go, Docker, and Kubernetes
- **Enhanced Git Integration**: Branch info, staged/unstaged changes, stash count, ahead/behind indicators
- **Cross-platform Support**: Works on Linux, macOS, and WSL/Windows
- **Smart Command Timing**: Visual feedback for long-running commands
- **Battery Status**: With charging/discharging indicators and color-coded levels
- **System Metrics**: Load average and memory usage indicators
- **SSH Session Indicator**: Clear visual marker when connected via SSH
- **Customizable**: Easy to modify colors, symbols, and displayed information

## 🚀 Installation

### Manual Installation

1. Clone or download this repository:
   ```bash
   git clone https://github.com/mohdismailmatasin/suprima-asra.git
   ```

2. Copy the theme file to your oh-my-zsh custom themes directory:
   ```bash
   cp suprima-asra/suprima-asra.zsh-theme ~/.oh-my-zsh/custom/themes/
   ```

3. Set the theme in your `~/.zshrc` file:
   ```bash
   ZSH_THEME="suprima-asra"
   ```

4. Reload your zsh configuration:
   ```bash
   source ~/.zshrc
   ```

### Using with Oh My Zsh Custom Repository

Add this repository as a custom theme source in your oh-my-zsh custom plugins/themes setup.

## 📋 Requirements

- Zsh shell (version 5.0 or higher recommended)
- Oh My Zsh framework (optional but recommended)
- Powerline fonts or Nerd Fonts for optimal symbol display (optional)
- For full feature support:
  - `git` for version control information
  - `kubectl` for Kubernetes context
  - `docker` for Docker status
  - `rustc` for Rust environment detection
  - `go` for Go environment detection
  - `node` and/or `npm` for Node.js environment detection
  - `python` or `conda` for Python environment detection

## 🎨 Customization

### Color Variables

The theme uses ANSI color codes that you can modify in the theme file:

```bash
# Example color variables
ANSI_reset="\x1b[0m"
ANSI_dim_black="\x1b[0;30m"
ANSI_grey="\x1b[0;37m"
ANSI_dim_grey="\x1b[2;37m"
```

### Symbol Customization

Modify these variables to change the symbols used:

```bash
char_arrow="›"                                                  # Unicode: \u203a
char_up_and_right_divider="└"                                   # Unicode: \u2514
char_down_and_right_divider="┌"                                 # Unicode: \u250c
char_vertical_divider="─"                                       # Unicode: \u2500
```

### Information Components

Enable/disable specific information components in the `RPROMPT` variable:

```bash
RPROMPT='$(cmd_exec_time)$(system_load)$(memory_usage)$(k8s_context)$(docker_status)$(rust_env_status)$(go_env_status)$(node_env_status)$(python_env_status)$(command_status)%F{yellow}%*%f | $(battery_status)'
```

Simply remove any component you don't want to display.

## 💡 Usage Examples

### Git Status Indicators

- **Branch**: Shows current git branch
- **Staged Changes**: Green "A" indicator
- **Unstaged Changes**: Cyan "M" indicator  
- **Untracked Files**: Blue "U" indicator
- **Stash Count**: Magenta "S" followed by number
- **Ahead/Behind**: Green ↑ and red ↓ arrows with commit counts

### Environment Indicators

- **Python**: 🐍 with environment name (virtualenv or conda)
- **Node.js**: ⬢ with version number
- **Rust**: 🦀 with version number
- **Go**: 🐹 with version number
- **Docker**: 🐳 with container count when running
- **Kubernetes**: ⎈ with context name

### System Information

- **Battery**: 🔋 or ⚡ with percentage (color-coded by level)
- **System Load**: 📊 with load average (color-coded)
- **Memory Usage**: 🧠 with percentage (color-coded)
- **Command Timing**: ⏱ with execution time for slow commands
- **Last Command Status**: ✗ or specific icons for failed commands with exit code

## 🎯 Color Coding

The theme uses intuitive color coding for quick visual feedback:

- **Green**: Success, good status, low resource usage
- **Yellow**: Warning, moderate resource usage
- **Red**: Error, high resource usage, critical status
- **Blue**: Informational, neutral status
- **Cyan**: Git-related information
- **Magenta**: Special indicators (like stash count)
- **White/Grey**: Separators and less important information

## 🔧 Troubleshooting

### Symbols Not Displaying Correctly

If you see strange characters instead of icons:
1. Install a Nerd Font or Powerline font
2. Configure your terminal to use the font
3. Ensure your terminal supports UTF-8 characters

### Performance Issues

If you notice slow prompt rendering:
1. Ensure you have a recent version of Zsh
2. Check that git is properly installed and in your PATH
3. Consider disabling expensive checks by commenting out unused components in RPROMPT

### Missing Information

If certain information isn't displaying:
1. Verify the required tools are installed (git, docker, kubectl, etc.)
2. Check that you're in a directory where the information is relevant (e.g., git repo for git status)
3. Ensure you have appropriate permissions to access system information

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Based on the Ultima Zsh Theme by [egorlem](https://github.com/egorlem/ultima.zsh-theme)
- Inspired by various powerline and informative Zsh themes
- Thanks to the Oh My Zsh community for excellent framework and documentation

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Support

If you encounter any issues or have questions, please file an issue on the GitHub repository.

---

Enhanced with ❤️ for developers who spend their days in the terminal.
