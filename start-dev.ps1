param(
    [string]$PhpPath = '',
    [ValidateRange(1024,65535)][int]$BackendPort = 8010,
    [ValidateRange(1024,65535)][int]$FrontendPort = 5180,
    [switch]$BackendOnly
)
$ErrorActionPreference = 'Stop'
$repoRoot = $PSScriptRoot
if (-not (Test-Path -LiteralPath (Join-Path $repoRoot '.env'))) { throw 'Run npm run setup first.' }
if (-not $PhpPath) {
    $phpCommand = Get-Command php -ErrorAction SilentlyContinue
    if ($phpCommand) { $PhpPath = $phpCommand.Source }
    else { $PhpPath = @('C:\xampp\php\php.exe','D:\xampp\php\php.exe') | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1 }
}
if (-not $PhpPath -or -not (Test-Path -LiteralPath $PhpPath)) { throw 'PHP not found. Pass -PhpPath with your PHP executable.' }
if ($BackendPort -eq $FrontendPort) { throw 'Frontend and backend must use different ports.' }
foreach ($port in @($BackendPort,$FrontendPort)) {
    if (Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue) { throw "Port $port is occupied. Stop the process or select another port; v2 never reuses an unknown server." }
}
$sessionPath = Join-Path $repoRoot 'backend\storage\sessions-v2'
[System.IO.Directory]::CreateDirectory($sessionPath) | Out-Null
$phpArguments = @('-d',"session.save_path=""$sessionPath""",'-S',"127.0.0.1:$BackendPort",'-t','backend/public')
$backendProcess = Start-Process -FilePath $PhpPath -ArgumentList $phpArguments -WorkingDirectory $repoRoot -WindowStyle Hidden -PassThru
$leaveRunning = $false
$savedTarget = $env:BLOODMATCH_API_TARGET
$savedPort = $env:BLOODMATCH_FRONTEND_PORT
try {
    $ready = $false
    for ($attempt = 0; $attempt -lt 30; $attempt++) {
        if ($backendProcess.HasExited) { throw 'The PHP backend exited before it was ready.' }
        try {
            $response = Invoke-RestMethod -Uri "http://127.0.0.1:$BackendPort/api/csrf" -TimeoutSec 2
            if ($response.success -and $response.data.csrf_token) { $ready = $true; break }
        } catch { }
        Start-Sleep -Milliseconds 500
    }
    if (-not $ready) { throw 'The v2 backend did not pass its CSRF readiness check.' }
    Write-Output "BloodMatch v2 API: http://127.0.0.1:$BackendPort"
    if ($BackendOnly) {
        $leaveRunning = $true
        Write-Output "Backend left running. Stop it with: Stop-Process -Id $($backendProcess.Id)"
    } else {
        $env:BLOODMATCH_API_TARGET = "http://127.0.0.1:$BackendPort"
        $env:BLOODMATCH_FRONTEND_PORT = "$FrontendPort"
        Write-Output "BloodMatch v2 frontend: http://localhost:$FrontendPort"
        Push-Location $repoRoot
        try {
            & npm.cmd --prefix frontend run dev
            if ($LASTEXITCODE -ne 0) { throw 'Vite exited with an error.' }
        } finally { Pop-Location }
    }
} finally {
    $env:BLOODMATCH_API_TARGET = $savedTarget
    $env:BLOODMATCH_FRONTEND_PORT = $savedPort
    if (-not $leaveRunning -and -not $backendProcess.HasExited) { Stop-Process -Id $backendProcess.Id -Force }
}
