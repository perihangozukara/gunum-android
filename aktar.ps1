# Günüm'ü Android projesine aktarır.
# Kaynak her zaman C:\Peri\gunum klasörüdür; buradaki www klasörü onun kopyasıdır (elle değiştirme).
$kaynak = "C:\Peri\gunum"
$hedef = Join-Path $PSScriptRoot "www"

if (Test-Path $hedef) { Remove-Item $hedef -Recurse -Force -Confirm:$false }
New-Item -ItemType Directory -Force $hedef | Out-Null

Get-ChildItem $kaynak -File | Where-Object { $_.Extension -in ".html", ".png", ".webmanifest" } |
    Copy-Item -Destination $hedef

Set-Location $PSScriptRoot
npx cap sync android
