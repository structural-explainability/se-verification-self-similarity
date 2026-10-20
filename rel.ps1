#Requires -Version 7.3

<#
Run release validation for the self-similarity verification repository.

Validates Lean source, tests, lint, reference TOML files,
documentation, and the repository manifest.

Does not update dependencies, package code, stage changes,
or publish a release.
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true

function Invoke-Step {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Section,

        [Parameter(Mandatory = $true)]
        [string]$Command,

        [Parameter(Mandatory = $true)]
        [scriptblock]$Script
    )

    Write-Host ""
    Write-Host "============================================================"
    Write-Host $Section
    Write-Host "============================================================"
    Write-Host $Command

    & $Script
}

Push-Location $PSScriptRoot

try {
    # ============================================================
    # === A) Verify Lean environment ===
    # ============================================================

    Invoke-Step "A1) Lean version" "lean --version" {
        lean --version
    }

    Invoke-Step "A2) Lake version" "lake --version" {
        lake --version
    }

    # ============================================================
    # === B) Lean build, tests, and lint ===
    # ============================================================

    Invoke-Step "B1) Build Lean library" "lake build" {
        lake build
    }

    Invoke-Step "B2) Run Lean tests" "lake test" {
        lake test
    }

    Invoke-Step "B3) Run Lean linter" "lake lint" {
        lake lint
    }

    # ============================================================
    # === C) Validate research reference files ===
    # ============================================================

    Invoke-Step "C1) Parse reference TOML files" "Validate TOML syntax" {
        uv run python -c "
import pathlib
import tomllib

for name in ('cases.toml', 'upstream.toml'):
    path = pathlib.Path('reference') / name
    with path.open('rb') as file:
        tomllib.load(file)
    print(f'Valid TOML: {path}')
"
    }

    # ============================================================
    # === D) Build documentation ===
    # ============================================================

    Invoke-Step "D1) Build documentation" "uv run zensical build" {
        uv run zensical build
    }

    # ============================================================
    # === E) Validate repository manifest ===
    # ============================================================

    Invoke-Step `
        "E1) Validate repository manifest" `
        "uvx se-manifest-schema validate-manifest --path SE_MANIFEST.toml --strict" {
        uvx se-manifest-schema validate-manifest `
            --path SE_MANIFEST.toml `
            --strict
    }

    # ============================================================
    # === F) Final repository status ===
    # ============================================================

    Invoke-Step "F1) Show repository status" "git status --short" {
        git status --short
    }

    Write-Host ""
    Write-Host "============================================================"
    Write-Host "Repository validation completed successfully."
    Write-Host "============================================================"
}
finally {
    Pop-Location
}
