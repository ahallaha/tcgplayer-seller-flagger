$ZipPath = "./chrome-dist.zip"

if (Test-Path $ZipPath) {
  Remove-Item $ZipPath
}

if (Test-Path "manifest.json") {
  Remove-Item "manifest.json"
}
Copy-Item "./chrome/manifest.json" -Destination "./manifest.json"

if (Test-Path "storage.js") {
  Remove-Item "storage.js"
}
Copy-Item "./chrome/storage.js" -Destination "./storage.js"

if (Test-Path "main.min.js") {
  Remove-Item "main.min.js"
}
npx rollup ./main.js --file ./main.min.js --format iife

if (Test-Path "popup.min.js") {
  Remove-Item "popup.min.js"
}
npx rollup ./popup.js --file ./popup.min.js --format iife

$compress = @{
  Path             = "./icons", "entry.html", "main.min.js", "manifest.json", "popup.min.js", "styles.css"
  CompressionLevel = "Fastest"
  DestinationPath  = $ZipPath
}
Compress-Archive @compress