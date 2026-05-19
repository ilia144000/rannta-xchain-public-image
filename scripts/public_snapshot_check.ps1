$Root = Split-Path -Parent $PSScriptRoot
$CheckerPath = Join-Path $Root "scripts\public_snapshot_check.ps1"

$ForbiddenRegex = @(
    "(?i)PRIVATE_KEY\s*=",
    "(?i)SECRET\s*=",
    "(?i)TOKEN\s*=",
    "(?i)MNEMONIC\s*=",
    "(?i)PASSWORD\s*=",
    "(?i)API_KEY\s*=",
    "(?i)OPERATOR_TOKEN\s*=",
    "(?i)VALIDATOR_KEY\s*=",
    "(?i)RELAYER_PRIVATE_KEY\s*=",
    "(?i)SETTLEMENT_PRIVATE"
)

$ForbiddenFiles = @(
    ".env",
    ".env.local",
    ".env.production",
    "id_rsa",
    "id_ed25519"
)

$Files = Get-ChildItem -LiteralPath $Root -Recurse -File -Force

foreach ($File in $Files) {
    if ($File.FullName -match "\\.git\\") {
        continue
    }

    if ($File.FullName -eq $CheckerPath) {
        continue
    }

    if ($ForbiddenFiles -contains $File.Name) {
        throw "Forbidden file found: $($File.FullName)"
    }

    $Text = Get-Content -LiteralPath $File.FullName -Raw -ErrorAction SilentlyContinue

    foreach ($Pattern in $ForbiddenRegex) {
        if ($Text -match $Pattern) {
            throw "Forbidden pattern found: $Pattern in $($File.FullName)"
        }
    }
}

Write-Host "RANNTA_PUBLIC_SNAPSHOT_CHECK_OK"
