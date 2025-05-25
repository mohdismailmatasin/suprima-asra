# Suprima-Asra Zsh Theme

A beautiful and feature-rich zsh theme based on the [Ultima theme](https://github.com/egorlem/ultima.zsh-theme) by Egor Lem, enhanced with additional functionality and customizations.

## ✨ Features

### 🎨 Visual Elements

- **Clean minimalistic design** with Unicode box-drawing characters
- **Color-coded prompt** with intuitive visual hierarchy
- **Horizontal separator line** that spans the full terminal width
- **Custom arrow symbols** (›) for consistent visual flow

### 🔧 Git Integration

- **Real-time git status** with branch name display
- **File status indicators**:
  - `M` - Modified files (cyan)
  - `A` - Added/staged files (green)
  - `U` - Untracked files (blue)
- **Support for git actions** (merge, rebase, etc.)
- **Git hash display** (short 6-character format)
- **Multi-VCS support** (Git, SVN, Mercurial)

### 🌐 System Information

- **SSH connection indicator** - Shows "SSH:" when connected remotely
- **Battery status** with visual indicators:
  - 🔋 Green (>80%), Yellow (30-80%), Red (<30%)
  - ⚡ Charging indicator
- **Public IP address** display (when online)
- **Current time** in the right prompt
- **Exit status** of last command with error indicator (✗)

### 💻 Enhanced Terminal Experience

- **Smart tab completion** with menu selection
- **Case-insensitive completion**
- **Colored file listings** (LS_COLORS)
- **Enhanced man page** viewing with colors
- **Caching for faster completions**

## 📦 Versions

### Version 1 (`suprima-asra_v1.zsh-theme`)

- Basic prompt with current directory
- All core features included

### Version 2 (`suprima-asra_v2.zsh-theme`)

- **Enhanced prompt** with username@hostname display
- Color-coded user info: username (green), @ (white), hostname (blue)
- All features from v1 plus user identification

## 🔧 Prerequisites

- **Zsh shell** (version 5.0 or higher)
- **Git** (for version control features)
- **curl** (for public IP functionality)
- **Unicode-capable terminal** (for proper symbol display)

### Recommended Terminal Emulators

- iTerm2 (macOS)
- Alacritty
- Kitty
- GNOME Terminal
- Windows Terminal

## 📥 Installation

### Method 1: Manual Installation

1. **Clone or download** the theme files:

   ```bash
   git clone <repository-url>
   cd "zsh theme"
   ```

2. **Copy theme file** to your zsh themes directory:

   ```bash
   # For Oh My Zsh users
   cp suprima-asra_v2.zsh-theme ~/.oh-my-zsh/themes/

   # For manual zsh setup
   mkdir -p ~/.zsh/themes
   cp suprima-asra_v2.zsh-theme ~/.zsh/themes/
   ```

3. **Apply the theme**:

   **For Oh My Zsh users:**

   ```bash
   # Edit ~/.zshrc
   ZSH_THEME="suprima-asra_v2"
   ```

   **For manual setup:**

   ```bash
   # Add to ~/.zshrc
   source ~/.zsh/themes/suprima-asra_v2.zsh-theme
   ```

4. **Reload your shell**:

   ```bash
   source ~/.zshrc
   # or restart your terminal
   ```

### Method 2: Direct Integration

1. **Append theme content** directly to your `~/.zshrc`:

   ```bash
   cat suprima-asra_v2.zsh-theme >> ~/.zshrc
   source ~/.zshrc
   ```

### Method 3: Symlink (Recommended for Development)

1. **Create a symlink** for easy updates:

   ```bash
   ln -sf "$(pwd)/suprima-asra_v2.zsh-theme" ~/.oh-my-zsh/themes/
   ```

## ⚙️ Configuration

### Customizing Colors

Edit the theme file to modify colors:

```bash
# Example: Change branch name color from green to blue
vc_branch_name="%F{blue}%b%f"  # Change green to blue
```

### Disabling Features

```bash
# Disable public IP display
get_public_ip() { echo ""; }

# Disable battery status
battery_status() { echo ""; }
```

### VCS Configuration

The theme supports multiple version control systems:

```bash
export VCS="git"    # Default
# export VCS="svn"  # For Subversion
# export VCS="hg"   # For Mercurial
```

## 🎯 Prompt Structure

```
┌─────────────────────────────────────────────────────────────
└ [SSH:] [user@hostname] /current/directory on › branch-name
 › 
```

**Right side:** `[✗ exit-code |] [public-ip |] time | battery`

## 🔍 Troubleshooting

### Unicode Characters Not Displaying

- Ensure your terminal supports Unicode
- Install a powerline-compatible font
- Check terminal encoding (should be UTF-8)

### Git Status Not Showing

- Verify you're in a git repository
- Check git installation: `git --version`
- Ensure git is in your PATH

### Battery Status Not Working

- Linux only feature (uses `/sys/class/power_supply/BAT0`)
- For other systems, the battery function will silently fail

### Slow Prompt

- Disable public IP lookup for faster prompt
- Check network connectivity if IP lookup hangs

## 🙏 Credits

- **Original Ultima Theme**: [Egor Lem](https://github.com/egorlem/ultima.zsh-theme)
- **Enhancements**: Suprima-Asra modifications
- **Inspiration**: Various zsh themes from the community

## 📄 License

This theme inherits the license from the original Ultima theme. Please refer to the original repository for licensing information.

## 🤝 Contributing

Feel free to submit issues, feature requests, or pull requests to improve this theme!

---

**Enjoy your enhanced terminal experience! 🚀**
