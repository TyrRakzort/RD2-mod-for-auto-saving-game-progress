SAVE SENTINEL – RDR2 AUTOBACKUP SYSTEM

📝 Overview:
A complete automatic backup solution for Red Dead Redemption 2. This mod links together three scripts (.lua, .vbs, .bat) to run a background backup routine without interrupting gameplay. From the moment your save loads, a watchful system kicks in to protect your progress minute by minute.

⚙️ Mod Architecture:
| Component | Function | Details | 
| autoBackup.lua | Triggers the .vbs when gameplay begins | Uses RedLua to execute once per game session | 
| Laucher.vbs | Silently runs the .bat and logs activity | Hidden process; logs the action to a local text file | 
| RDR2-Start_save_backup.bat | Monitors game status and backs up save file | Rotates up to three backups; handles file locks and cleanup routines | 

🧠 Key Features:
- 🕶️ Stealthy execution — no pop-up windows
- 💾 Automated backup rotation every 60 seconds
- 🛡️ Permission checks and RDR2 process detection
- 📜 Activity logging with timestamp
- 🔄 Smart cycle control with file cleanup logic

📂 Your save game files are located in::
C:\Users\your Windows profile\Documents\Rockstar Games\Red Dead Redemption 2\Profiles\Your save game files (this number varies for each person).

🚀 Installation:
- Place autoBackup.lua in RedLua’s script folder.
- Keep Laucher.vbs and the .bat in the your save game files
- In the .lua file, customize your profile ID(Your save game files)
- In the RDR2-SAVE_SENTINEL file, you can modify the save game name and the time interval for saving the game.

 set "PARTIDA=SRDR30015"  --> the save game name.
 set /a INTERVALO=60 --> the time interval for saving the game.

- Start the game and load your save — the backup system will activate automatically.

Mod created by TyrRakzort – Save Sentinel RDR2 – July 2025. This project is protected by copyright
