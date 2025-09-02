```markdown
# FileWhisperer 🗂️🗣️

A simple yet smart batch script that organizes files into subfolders based on their extensions — and even whispers back to you with speech when the task is done.

## 🚀 Features
- 📂 Automatic Sorting: Organizes files into subfolders by extension (`.jpg`, `.mp3`, `.pdf`, etc.).
- 📝 Custom Folder Selection: User inputs the folder path at runtime.
- 🗣️ Speech Feedback: Announces success using Windows' text-to-speech engine.
- ⚡ Lightweight & Fast: Runs instantly, no external dependencies.

## 🖥️ Usage
1. Clone or download this repository.
2. Run `FileWhisperer.bat` by double-clicking or via Command Prompt.
3. Enter the full path of the folder you want to organize.
4. Files will be sorted into subfolders automatically.
5. FileWhisperer will confirm success with speech.

## 📂 Example
Before:
```

report.docx
song.mp3
holiday.jpg
script.bat
notes.pdf

```

After running FileWhisperer:
```

\docx
report.docx
\mp3
song.mp3
\jpg
holiday.jpg
\bat
script.bat
\pdf
notes.pdf

```

## 🔧 Requirements
- Windows OS
- PowerShell (pre-installed on modern Windows)

## 🎤 Demo
When finished, FileWhisperer will say:
> "Tada! Files organized successfully."

## 💡 Future Ideas
- Add an option to ignore certain extensions.
- Create a log file of all file movements.
- Add support for custom folder names (e.g., `.jpg` → “Images”).

## 📜 License
This project is licensed under the MIT License — feel free to use, modify, and share.
```
