# Friendster Wayback Search :P

Write-Host ""
Write-Host "Friendster Wayback Search"
Write-Host "========================="
Write-Host ""

$search = Read-Host "What do you want to search for?"

# Don't search for nothing lol

if ([string]::IsNullOrWhiteSpace($search)) {
Write-Host "You didn't enter anything to search for." -ForegroundColor Yellow
Read-Host "Press Enter to close"
exit
}

# Num of profiles to check

$limit = 50

# Old Friendster links + the newer ones

$sites = @(
"http://www.friendster.com/*",
"http://profiles.friendster.com/*"
)

$found = 0
$checked = 0
$failed = 0
$foundMatches = @()

foreach ($site in $sites) {

```
Write-Host ""
Write-Host "Looking for profiles in $site ..."
Write-Host ""

# Encode the URL because otherwise some chars can cause problems
$url = [uri]::EscapeDataString($site)

# CDX gives us the archived URLs and dates
$cdx = "https://web.archive.org/cdx/search/cdx?url=$url&output=json&filter=statuscode:200&filter=mimetype:text/html&collapse=urlkey&limit=$limit"

try {
    $results = Invoke-RestMethod $cdx
}
catch {
    Write-Host "Couldn't get the list from Wayback." -ForegroundColor Red
    continue
}

# NO results :(
if ($results.Count -le 1) {
    Write-Host "No profiles found."
    continue
}

# First row is basically the column names
$headers = $results[0]
$urlNumber = [Array]::IndexOf($headers, "original")
$dateNumber = [Array]::IndexOf($headers, "timestamp")

$profiles = $results | Select-Object -Skip 1

Write-Host "Found $($profiles.Count) profiles."

$found += $profiles.Count

foreach ($profile in $profiles) {

    $original = $profile[$urlNumber]
    $date = $profile[$dateNumber]

    # Make the actual Wayback link
    $archive = "https://web.archive.org/web/${date}id_/$original"

    Write-Host "Checking $original"

    try {
        # Download the archived page
        $page = Invoke-WebRequest $archive -UseBasicParsing -TimeoutSec 20
        $checked++

        # Just searching the downloaded HTML for the text
        if ($page.Content -match [regex]::Escape($search)) {

            Write-Host ""
            Write-Host "!!! MATCH FOUND !!!" -ForegroundColor Green
            Write-Host "Profile: $original" -ForegroundColor Green
            Write-Host "Date: $date" -ForegroundColor Green
            Write-Host "Wayback: $archive" -ForegroundColor Green
            Write-Host ""

            # Save it so we can see everything at the end
            $foundMatches += [PSCustomObject]@{
                Profile = $original
                CaptureDate = $date
                Wayback = $archive
            }
        }
    }
    catch {
        $failed++
        Write-Host "Couldn't retrieve this one." -ForegroundColor Yellow
    }
}
```

}

Write-Host ""
Write-Host "========================="
Write-Host "Done!"
Write-Host "========================="
Write-Host "Profiles found:   $found"
Write-Host "Profiles checked: $checked"
Write-Host "Couldn't retrieve: $failed"
Write-Host "Matches:          $($foundMatches.Count)"
Write-Host ""

if ($foundMatches.Count -gt 0) {

```
Write-Host "Matches:"
Write-Host ""

foreach ($match in $foundMatches) {
    Write-Host "Profile: $($match.Profile)"
    Write-Host "Date:    $($match.CaptureDate)"
    Write-Host "Wayback: $($match.Wayback)"
    Write-Host ""
}
```

}
else {
Write-Host "No matches found."
}

Read-Host "Press Enter to close"
