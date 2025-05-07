Get-Mailbox -ResultSize Unlimited | Where-Object { -not $_.AutoExpandingArchiveEnabled } | ForEach-Object {
    Enable-Mailbox -Identity $_.Identity -AutoExpandingArchive
    Write-Host "Enabled auto-expanding archive for $($_.UserPrincipalName)"
}
