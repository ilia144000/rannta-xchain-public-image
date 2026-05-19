$Root = Split-Path -Parent $PSScriptRoot

$ForbiddenPatterns = @(
    ".env",
    "PRIVATE_KEY",
    "SECRET",
    "TOKEN=",
    "MNEMONIC",
    "RELAYER",
    "VALIDATOR_KEY",
    "SETTLEMENT_PRIVATE",
    "OPERATOR_TOKEN"
)

$Files = Get-ChildItem -LiteralPath $Root -Recurse -File

foreach ($File in $Files) {
    $Text = Get-Content -LiteralPath $File.FullName -Raw -ErrorAction SilentlyContinue
    foreach ($Pattern in $ForbiddenPatterns) {
        if ($Text -match [regex]::Escape($Pattern)) {
            throw "Forbidden pattern found: $Pattern in $($File.FullName)"
        }
    }
}

Write-Host "RANNTA_PUBLIC_SNAPSHOT_CHECK_OK"
