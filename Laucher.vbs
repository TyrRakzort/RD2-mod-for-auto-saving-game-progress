Set fso = CreateObject("Scripting.FileSystemObject")
Set WshShell = CreateObject("WScript.Shell")

' Current folder where the VBS is located
carpetaActual = fso.GetParentFolderName(WScript.ScriptFullName)

' Run the BAT file in hidden mode as if it were launched manually
batPath = carpetaActual & "\RDR2-SAVE_SENTINEL.bat"
WshShell.Run chr(34) & batPath & chr(34), 0, False

' Register in local log
logPath = carpetaActual & "\RDR2_backup_log.txt"
Set logFile = fso.OpenTextFile(logPath, 8, True) ' Modo append
logFile.WriteLine "[" & Time & "] Backup BAT running in the background"
logFile.Close

' Mod created by TyrRakzort – Save Sentinel RDR2 – July 2025. This project is protected by copyright