# 📁 DirectoryMonitor — Super Simple Folder Watcher

This is a PowerShell script that watches a folder on your computer and tells you when someone creates a new folder inside it.

---

## 🧠 What This Is

Imagine you want to keep an eye on a folder — like your **Documents** — and want to know if **any new folders or subfolders** are added. This tool does that.

You don’t need to know how to code or install anything fancy.

---

## 🚀 How to Use This (No Tech Knowledge Needed)

### ✅ Step 1: Download the Script File

1. Go to the GitHub page here: https://github.com/TevansZAP/DirectoryMonitor
2. Find the file called `Monitor-Folders.ps1`
3. Click the file, then click the **Download raw** button or the **Download ZIP** (then unzip it)

---

### ✅ Step 2: Find the Folder You Want to Watch

1. Open **File Explorer**
2. Navigate to the folder you want to monitor (like `Documents`)
3. Click in the top bar of the window (where the folder path is), it will turn into something like this:
   ```
   C:\Users\YourName\Documents
   ```
4. **Right-click and choose Copy** — this is the path you’ll use in the next step.

---

### ✅ Step 3: Run the Script

1. Click the Windows Start Menu
2. Type `powershell`
3. **Right-click** on "Windows PowerShell" and choose **Run as Administrator**
4. In PowerShell, type this (but **paste your folder path** in place of mine):

   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```

   Press `Y` if asked.

5. Next, go to where you saved the script — like your Downloads folder:

   ```powershell
   cd "C:\Users\YourName\Downloads"
   ```

6. Run the script like this:

   ```powershell
   .\Monitor-Folders.ps1 -RootPath "C:\Users\YourName\Documents"
   ```

---

## 📂 What Happens When You Run It?

- It will show you all the folders it sees right now.
- If it finds any **new folders** since last time, it will list them.
- It will save this info in 2 files:
  - `snapshot.json` (what it saw)
  - `new_directories.json` (new ones it found)

You don’t need to open or touch these files. Just run the script again later, and it’ll tell you what’s new.

---

## 🧼 How to Stop Using It

Just delete the file `Monitor-Folders.ps1` and the `.json` files if you don’t want them anymore. That’s it.

---

## ❓ Still Confused?

Open an issue on the GitHub page, or ask someone to help you copy/paste the path and run PowerShell. It only takes 2 minutes.

