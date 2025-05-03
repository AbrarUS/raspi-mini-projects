# Git Log Pretty Format Guide

## 📑 Table of Contents

- [🔍 What the command does](#-what-the-command-does)
- [🚀 Usage](#-usage)
  - [For Bash or Zsh](#for-bash-or-zsh)
- [🌏 Use `git lp` alias globally](#-use-git-lp-alias-globally)
- [🧩 Breakdown of --pretty=format switches](#-breakdown-of---prettyformat-switches)
- [📃 All Common Format Placeholders](#-all-common-format-placeholders)
- [🛠️ Other Usage Examples](#️-other-usage-examples)
  - [1. One-line Git log with branch/tag references](#1-one-line-git-log-with-branchtag-references)
  - [2. Compact log grouped by author](#2-compact-log-grouped-by-author)
  - [3. Recent history with date and message](#3-recent-history-with-date-and-message)
  - [4. Colored tree view + format](#4-colored-tree-view--format)
  - [5. Filter by author](#5-filter-by-author)

- [🧠 Pro Tips](#pro-tips)


---  
&nbsp;&nbsp;

```
git log --pretty=format:"%C(green)%an%Creset, %ar : %C(yellow)%s%Creset - %h"
```

## What the command does

This command shows Git commit logs in a **custom format**, using `--pretty=format` to display selected information from each commit in a colorized and human-readable way. Compared to the base command, `git log` which lists many details (commit hash, author, date, message) by default, with `--pretty=format`, you take full control over the output.

---
## 🚀 Usage

### For Bash or Zsh

#### 1. Add this alias to your `.bashrc`, `.bash_profile`, or `.zshrc`:

```bash
alias glp='cd directory1/directory2/ && git log --pretty=format:"%C(auto)%h %d%Creset %s %C(blue)[%cr] %C(green)<%an>"'
```

> ⚠️ Note: Do not include spaces around the `=` sign in alias definitions.

#### 2. Apply changes:

After editing your config file, run:

```bash
source ~/.bashrc    # or ~/.zshrc depending on your shell
```

#### 3. Use the alias:

Open Git Bash or any terminal and type:

```bash
glp
```

This command will:

* Navigate to `directory1/directory2/`
* Display the commit history in your custom, colorized, one-line log format

>↩️ Press `Enter` to keep loading more history.

>⛔ Press `q` to quit.

---
## 🌏 Use `git lp` alias globally
To add this as a global alias, open the terminal and use the `git config` command:

`git config --global alias.lp 'log --pretty=format:"%C(auto)%h %d %s %C(blue)(%cr)%C(reset) %C(green)<%an>"` 

Then just run `git lp` anywhere to get custom formatted git log.

The alias will be stored in the global Git configuration file, typically located at `~/.gitconfig`. 

```ini
[user]
	name = Abrar Shaikh
	email = xyz@email.com
[alias]
	lp = log --pretty=format:\"%C(auto)%h %d %s %C(blue)(%cr)%C(reset) %C(green)<%an>\"

```

> Use the `Preferences: Open User Settings` command to configure global Git settings in Visual Studio Code.

---

## 🧩 Breakdown of --pretty=format switches

Each placeholder inside `format:"..."` represents some metadata about the commit:

| Token       | Description                                                                       |
| ----------- | --------------------------------------------------------------------------------- |
| `%C(green)` | Set text color to green. You can use any color like `red`, `yellow`, `blue`, etc. |
| `%an`       | Author name.                                                                      |
| `%Creset`   | Reset text color/style back to default.                                           |
| `%ar`       | Relative date (e.g., "2 days ago"). Use `%ad` for absolute date.                  |
| `%s`        | Commit message subject (the first line).                                          |
| `%h`        | Abbreviated commit hash.                                                          |

So, your format:

```
%C(green)%an%Creset, %ar : %C(yellow)%s%Creset - %h
```

Will output something like:

```
Abrar Shaikh, 3 days ago : Fix login bug - a1b2c3d
```

With:

* Author name in green
* Commit message in yellow
* All styles reset after each colored section

---

## 📃 All Common Format Placeholders

You can use more than what's in your example. Some of the **most useful format options**:

| Code        | Meaning                                 |
| ----------- | --------------------------------------- |
| `%H`        | Full commit hash                        |
| `%h`        | Abbreviated commit hash                 |
| `%an`       | Author name                             |
| `%ae`       | Author email                            |
| `%cn`       | Committer name                          |
| `%ce`       | Committer email                         |
| `%s`        | Subject (message title)                 |
| `%b`        | Body of the commit message              |
| `%ar`       | Relative author date                    |
| `%ad`       | Absolute author date (can be formatted) |
| `%cd`       | Committer date                          |
| `%D`        | Ref names (e.g., tag, HEAD, branch)     |
| `%p`        | Parent hashes (for merges)              |
| `%C(color)` | Start colored text                      |
| `%Creset`   | Reset color                             |

---

## 🛠️ Other Usage Examples

### 1. One-line Git log with branch/tag references

```bash
git log --pretty=format:"%C(auto)%h %d%Creset %s %C(blue)[%cr] %C(green)<%an>"
```
* Shows hash, branch/tag info, subject, relative time, and author

>⚠️ Note: Directory Path Warning - Linux systems (Bash/Linux/macOS) use the forward slash `/` as the directory separator while Windows systems (PowerShell/CMD) use the backslash `\` as the directory separator.



### 2. Compact log grouped by author

```bash
git log --pretty=format:"%C(green)%an%Creset: %s" | sort | uniq -c | sort -nr
```

* Count and sort commits per author

### 3. Recent history with date and message

```bash
git log --since="2 weeks ago" --pretty=format:"%C(blue)%ad%Creset - %s" --date=short
```

* Shows commits from last 2 weeks with short date format

### 4. Colored tree view + format

```bash
git log --graph --pretty=format:"%C(yellow)%h%Creset - %C(cyan)%an%Creset: %s" --abbrev-commit
```

* Tree-structured history (great for visualizing branches)

### 5. Filter by author

```bash
git log --author="Abrar" --pretty=format:"%h %s [%ar]" --since="1 month ago"
```

* Your commits in the last month

---
## 🧠 Pro Tips

* Use `git log -p` or `git show <commit>` if you want diffs too
* Add `--name-only` to list modified files per commit

---


