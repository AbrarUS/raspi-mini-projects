# 📋 Raspberry Pi GitHub Project Best Practices Checklist

---

## 🛠️ 1. Create the GitHub Repo Carefully
- ✔️ Go to GitHub → `+ New Repository`
- ✔️ Decide:
  - ✅ **Name** (small, meaningful, lowercase, hyphens `-` if needed)
  - ✅ **Description** (optional but good)
  - ✅ **Public** or **Private**
- ⚠️ **Important**:  
  - ✅ **Do NOT** add README/Licence/gitignore **if you already have code locally**.  
  - ✅ **If you add README**, you must pull it first later (see step 5).

---

## 📂 2. Set up Local Project on Raspberry Pi
- ✔️ Create your project folder:

```bash
mkdir project-name
cd project-name
```

- ✔️ Initialize Git:

```bash
git init
```

- ✔️ Optional: Create a `.gitignore` to exclude unwanted files.

Example:

```plaintext
__pycache__/
.vscode/
*.pyc
*.DS_Store
```

---

## ⚡ 3. Set your Git Identity (if first time on this Raspberry Pi)

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

✅ This sets who you are globally on this device.

---

## 🔗 4. Connect Local Repo to GitHub Remote

```bash
git remote add origin git@github.com:yourusername/project-name.git
```
or if using HTTPS:

```bash
git remote add origin https://github.com/yourusername/project-name.git
```

---

## 🔄 5. If GitHub Repo Already Has README → Pull First!

If you created GitHub repo **with a README**, you MUST first:

```bash
git pull --rebase origin main
```

✅ This avoids conflicts before first push.

---

## 🚀 6. First Commit and Push
- ✔️ Stage everything:

```bash
git add .
```

- ✔️ Commit:

```bash
git commit -m "Initial commit"
```

- ✔️ Push:

```bash
git push -u origin main
```

✅ Now your project is online and ready to track!

---

## 🧹 Bonus Tips to Keep Your Git Repo Clean

| Best Practice | Why |
|:---|:---|
| Use small, meaningful commits | Easier to understand project history. |
| Write clear commit messages | Example: `Added WiFi priority switching script` |
| Push often | Keeps backups safe and work synchronized. |
| Regularly pull with `git pull --rebase` | Avoids messy merge commits. |
| Use branches for experiments | Keep `main` stable! Create branches like `wifi-fix` or `audio-upgrade`. |

---

# 🎯 Quick Visual Flow

```plaintext
Create GitHub Repo → git init locally → git remote add origin → git pull --rebase (if needed) → git add → git commit → git push
```