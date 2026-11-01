$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
Push-Location $repoRoot
try {
    if (-not (Test-Path -LiteralPath '.env')) {
        Copy-Item -LiteralPath '.env.example' -Destination '.env'
        Write-Output 'Created a fresh v2 .env; no capstone credentials were copied.'
    } else { Write-Output 'Keeping the existing local .env.' }
    foreach ($directory in @('logs','backend/storage/documents','backend/storage/profile_pictures','backend/storage/sessions-v2')) {
        [System.IO.Directory]::CreateDirectory((Join-Path $repoRoot $directory)) | Out-Null
    }
    & npm.cmd --prefix frontend ci
    if ($LASTEXITCODE -ne 0) { throw 'Frontend dependency installation failed.' }
    & node scripts/doctor.mjs
    if ($LASTEXITCODE -ne 0) { throw 'Development preflight failed.' }
    Write-Output 'Local tooling is ready. No database, migration, worker, or deployment was changed. Start with npm run dev.'
} finally { Pop-Location }
