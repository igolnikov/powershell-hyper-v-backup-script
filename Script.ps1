# the author of the code igolnikov igor
# to find out the machine id, use the command  get-vm | select VMNAME,VMId
# $alpine1 = 11111111-1111-1111-1111-111111111111'

$wm1 = "name of the virtual machine"

$date = Get-Date -Format "yyyyMMdd-HHmmss"

$backupPath = "C:\Backup\VMBackup_$wm1\"

$backupPathAlpine = "C:\Backup\VMBackup_$wm1\"

$backupPathArh = "C:\Backup\Arh\cryptedArh.7z"

# we check if there are files that have not been deleted
if (Test-Path $backupPath -PathType Container) {
    Write-Host $DeletebackupPathArh
} else {
    Write-Host "VMBackup_$wm1 does not exist"
}

if (Test-Path $backupPath -PathType Container) {
    Write-Host $DeletebackupPath
} else {
    Write-Host "cryptedArh.7z does not exist"
}

# exporting a virtual machine
Export-VM -Name $wm1 -Path $backupPath

# Creating an archive
$CompressArchive = 7z a -mx9 $backupPathArh $backupPathAlpine

# ----------------- crypted --------------
# Specify the password for encryption
$password = "your decryption password"

# Specify the path to create the encrypted archive
$encryptedFile = "C:\Backup\cript\$wm1-aes-256-cbc-salt-$date.enc"
# decoding "openssl aes-256-cbc -d -aes-256-cbc -in cript-aes-256-cbc-salt-20231211-161235.enc -out cryptedArh.7z"

# We use openssl to encrypt the archive
$cryptedArh = openssl aes-256-cbc -salt -in "$backupPathArh" -out "$encryptedFile" -k $password

# Deleting the temporary archive
$DeletebackupPathArh = Remove-Item -Recurse "$backupPathArh"
$DeletebackupPath = Remove-Item -Recurse "$backupPath"

# Completing the work
# Sending a message in telegram

$botToken = "1111111111:AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
$chatId = "111111111"
$message = "The $wm1 backup task has been completed successfully"

# Forming the request URL
$url = "https://api.telegram.org/bot$botToken/sendMessage?chat_id=$chatId&text=$message"

# Sending a request
Invoke-RestMethod -Uri $url -Method "GET"

Exit
