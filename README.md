### ✅ Step 1: Download the Script File

1. Go to the GitHub page (you're already here)
2. Find the file called `Monitor-Folders.ps1`
3. Click the file, then click the **Raw** button
4. Right-click anywhere on the page and choose **Save As...**
5. Save the file somewhere you can find it (like your **Downloads** or **Desktop**)

---

### ✅ Step 2: Find the Folder You Want to Watch

1. Open **File Explorer**
2. Navigate to the folder you want to keep an eye on
3. At the top of the window, click the white space in the address bar — it will turn into something like:

```text
C:\Users\YourName\Documents\MyFolder
```

4. Right-click that path and choose **Copy**

---

### ✅ Step 3: Run the Script

1. Click your **Start Menu**
2. Type `powershell`
3. **Right-click** on **Windows PowerShell** and choose **Run as Administrator**

---

### 🛠️ Get PowerShell ready to run scripts

```powershell
Set-ExecutionPolicy RemoteSigned
```

Then press **Enter**.  
If it asks you anything, type:

```powershell
Y
```

And press **Enter** again.

---

### 📁 Go to the folder where you saved the script

If you saved the script in your Downloads folder:

```powershell
cd "C:\Users\YourName\Downloads"
```

Or change the path to wherever you saved the script:

```powershell
cd "C:\Path\To\Where\You\Saved\The\Script"
```

---

### 👀 Run the script and tell it what folder to watch

```powershell
.\Monitor-Folders.ps1 -RootPath "C:\Path\To\Folder\You\Want\To\Watch"
```

---

### 💡 Example

Let’s say:
- You saved the script in:  
  `C:\Users\Sarah\Desktop`
- You want to watch:  
  `C:\Users\Sarah\Documents\Projects`

Then you’d run:

```powershell
cd "C:\Users\Sarah\Desktop"
.\Monitor-Folders.ps1 -RootPath "C:\Users\Sarah\Documents\Projects"
```