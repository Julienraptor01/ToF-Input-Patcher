$timestamp = Get-Date -Format o | ForEach-Object { $_ -replace ":", "." }
$version = "0.0.0-dev"
$convertFrom = "QWERTY (en-US)"
$convertTo = "AZERTY (fr-FR)"
if ( -not ( Test-Path -Path $Home\"ToF Input Patcher" ) ) {
	$(
		New-Item -Path $Home -Name "ToF Input Patcher" -ItemType "directory"
		New-Item -Path $Home\"ToF Input Patcher" -Name "Backups" -ItemType "directory"
		New-Item -Path $Home\"ToF Input Patcher" -Name "Logs" -ItemType "directory"
	) *>> $Home\TEMPTOFIP$timestamp.log
	Move-Item $Home\TEMPTOFIP$timestamp.log $Home\"ToF Input Patcher"\Logs\$timestamp.log
	$(
		Write-Output "`r`nLe log a été déplacé au bon endroit.`r`n"
	) *>> $Home\"ToF Input Patcher"\Logs\$timestamp.log
}
else {
	$(
		if ( -not ( Test-Path -Path $Home\"ToF Input Patcher"\Logs ) ) {
			New-Item -Path $Home\"ToF Input Patcher" -Name "Logs" -ItemType "directory"
		}
	) *>> $Home\TEMPTOFIP$timestamp.log
	Move-Item $Home\TEMPTOFIP$timestamp.log $Home\"ToF Input Patcher"\Logs\$timestamp.log
	$(
		Write-Output "`r`nLe log a été déplacé au bon endroit.`r`n"
	) *>> $Home\"ToF Input Patcher"\Logs\$timestamp.log
	$(
		if ( -not ( Test-Path -Path $Home\"ToF Input Patcher"\Backups ) ) {
			New-Item -Path $Home\"ToF Input Patcher" -Name "Backups" -ItemType "directory"
		}
	) *>> $Home\"ToF Input Patcher"\Logs\$timestamp.log
}
$(
	Write-Output "Salut !`r`nCeci est la version $version de Tower of Fantasy Input Patcher pour convertir de $convertFrom en $convertTo !`r`n`r`nLancer le script sur un Input.ini déjà converti créera des problèmes.`r`nÊtes-vous sûr de vouloir lancer le script ?"
) *>&1 | Tee-Object -Append $Home\"ToF Input Patcher"\Logs\$timestamp.log
$patch = Read-Host 'Répondez "true" pour oui et "false" pour non '
$(
	Write-Output "`r`nVous avez répondu '$patch'."
) *>&1 | Tee-Object -Append $Home\"ToF Input Patcher"\Logs\$timestamp.log
if ( $patch -eq $true ) {
	Set-Location $Env:LocalAppData\Hotta\Saved\Config\WindowsNoEditor
	Copy-Item .\Input.ini $Home\"ToF Input Patcher"\Backups\"Input $timestamp.ini"
	$(
		Write-Output "`r`nUne backup a été créée : $Home\ToF Input Patcher\Backups\Input $timestamp.ini"
	) *>&1 | Tee-Object -Append $Home\"ToF Input Patcher"\Logs\$timestamp.log
	Set-ItemProperty .\Input.ini IsReadOnly $false
	(Get-Content .\Input.ini).Replace('=Tilde','=TEMP²') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=One','=TEMPAmpersand') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Two','=TEMPE_AccentAigu') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Three','=TEMPQuote') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Four','=TEMPApostrophe') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Five','=TEMPLeftParantheses') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Six','=TEMPHyphen') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Seven','=TEMPE_AccentGrave') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Eight','=TEMPUnderscore') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Nine','=TEMPC_Cedille') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Zero','=TEMPA_AccentGrave') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Hyphen','=TEMPRightParantheses') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Q)','=TEMPA)') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=W)','=TEMPZ)') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=LeftBracket','=TEMPCaret') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=RightBracket','=TEMPDollar') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=A)','=TEMPQ)') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Semicolon','=TEMPM') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Apostrophe','=TEMPù') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Backslash','=TEMPAsterisk') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Z)','=TEMPW)') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=M)','=TEMPComma)') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Comma','=TEMPSemicolon') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Period','=TEMPColon') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('=Slash','=TEMPExclamation') | Set-Content .\Input.ini
	(Get-Content .\Input.ini).Replace('TEMP','') | Set-Content .\Input.ini
	Set-ItemProperty .\Input.ini IsReadOnly $true
	$(
		Write-Output "`r`nVotre Input.ini a été patch.`r`nLe script va être supprimé après la fermeture pour être sûr que vous ne le relanciez pas.`r`nCeci est un mécanisme de protection pour ne pas casser votre Input.ini"
	) *>&1 | Tee-Object -Append $Home\"ToF Input Patcher"\Logs\$timestamp.log
	Get-ChildItem $PSScriptRoot | Where{$_.Name -Match 'QWERTY \(en\-US\) to AZERTY \(fr\-(FR|BE)\).*\.ps1'} | Remove-Item
}
if ( $patch -ne $true -and $patch -ne $false ) {
	Write-Output "`r`nJ'ai dit TRUE ou FALSE !!!`r`nC'est si compliqué de lire ?"
}
$(
Write-Output "`r`nLe script va se fermer."
	) *>&1 | Tee-Object -Append $Home\"ToF Input Patcher"\Logs\$timestamp.log
Pause