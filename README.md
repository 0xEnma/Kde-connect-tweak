🚀 KDE Connect Multi-File Sender (Windows)

  A lightweight, robust Batch script that enables batch file sharing for KDE Connect on Windows. This script allows you
  to select multiple files in File Explorer and send them all at once to your paired devices via the "Send To" context
  menu.

  🌟 Why use this?

  By default, the KDE Connect Windows "Send to" shortcut often:
   1. Only supports one file at a time, or
   2. Opens a new window/handler for every single file you select, which is slow and cluttered.

  This script solves that by collecting all selected files and passing them to the kdeconnect-cli in a single command,
  making the transfer significantly faster and cleaner.

  ---

  ✨ Features

   - Multi-File Support: Select 10, 50, or 100 files and send them in one go.
   - Smart Device Discovery: Automatically detects which of your paired devices are currently online.
   - Auto-Select: If only one device is reachable, it skips the menu and sends immediately.
   - Interactive Menu: If multiple devices are online, it lets you choose the target by number.
   - Connectivity Alerts: Provides clear feedback if your phone is offline or on a different Wi-Fi network.

  ---

  🛠️ Installation

   1. Download the Send to KDE Connect.bat file from this repository.
   2. Open the Windows Run dialog (Press Win + R).
   3. Type shell:sendto and press Enter. This opens your "Send To" shortcuts folder.
   4. Move the downloaded .bat file into this folder.

  ---

  📖 How to Use

   1. Open File Explorer and select multiple files.
   2. Right-click on any of the selected files.
   3. Navigate to Send to > Send to KDE Connect.bat.
   4. A terminal will briefly open:
       - If one device is online, files are sent immediately.
       - If multiple devices are online, type the number of your target device and press Enter.
   5. Wait for the "Success" message and press any key to close.

  ---

  ⚠️ Requirements

   - KDE Connect for Windows must be installed.
   - Your PC and Phone must be paired and on the same Wi-Fi network.
   - This script assumes KDE Connect is installed in the default location:
    %LocalAppData%\Programs\KDE Connect\bin\kdeconnect-cli.exe
<img width="630" height="625" alt="67AWgPHo4a" src="https://github.com/user-attachments/assets/99b74c30-2028-4790-8a00-0c735113847d" />
<img width="1233" height="626" alt="SdAP59noSU" src="https://github.com/user-attachments/assets/1da2ec33-36a9-4452-b365-2f416356d249" />
<img width="1233" height="626" alt="WindowsTerminal_EKHthwnqsf" src="https://github.com/user-attachments/assets/5520432b-fff0-47f9-9abf-62a3763ebc41" />



  ---

  🔧 Troubleshooting

   - "No reachable devices found": Ensure the KDE Connect app is open on your phone and your phone's screen is on. Check
     if your Windows Firewall is blocking KDE Connect.
   - Terminal closes instantly: This usually happens if the script can't find kdeconnect-cli.exe. Verify your
     installation path and update the CLI_EXE variable in the script if necessary.

  ---

  📝 License

  This project is licensed under the MIT License - feel free to modify and share!

  ---

  🙌 Contributing
  Found a bug or have an idea for a feature? Feel free to open an Issue or a Pull Request!
