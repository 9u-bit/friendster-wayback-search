# Friendster Wayback Search :P

A small PowerShell script for searching **publicly archived Friendster profile pages** through the Wayback Machine.

I made this because I was curious about old Friendster profiles and wanted an easier way to search through some of the pages that were preserved by web archives.

It's nothing fancy. It basically:

1. Gets archived Friendster profile URLs from the Wayback Machine.
2. Downloads the archived HTML pages.
3. Searches the pages locally for whatever text you enter.
4. Shows you the profiles where a match was found.

## What it searches

The script currently checks two Friendster URL formats:

* `www.friendster.com/*`
* `profiles.friendster.com/*`

This is useful because older Friendster profiles can appear under different URL formats.

## Requirements

You'll need:

* Windows
* PowerShell
* An internet connection xD
* Access to the Wayback Machine

No extra PowerShell modules are required.

## How to use

Clone or download this repository.

Then open PowerShell in the project folder and run:

```powershell
.\friendster-wayback-search.ps1
```

The script will ask:

```text
What do you want to search for?
```

Enter the text you want to look for.

For example:

```text
someusername
```

or:

```text
Example Name
```

The script then checks the archived profile pages and prints any matches it finds.

## Important thing to know

This script does **not** search Friendster's old database directly.

It searches pages that are publicly available through the Wayback Machine.

Because of that, a profile can exist in an archive and still produce no match if:

* The page wasn't archived.
* The archived version doesn't contain the text you're searching for.
* The relevant information was loaded dynamically.
* The capture can't currently be retrieved.
* The profile uses a different URL that isn't included in the current search.
* The information was never publicly displayed on the profile.

So basically: **no match does not necessarily mean no archived profile.**

## Privacy

The search text is entered locally with PowerShell's `Read-Host`.

It is **not added to the Wayback CDX search URL**.

The CDX request is only used to retrieve lists of archived Friendster URLs. The downloaded pages are then searched locally on your computer.

Still, don't put private information into this repository, screenshots, examples, or Git commits.

Especially don't commit someone's email address, password, private messages, or other personal information.

## Limitations

The current version only checks a limited number of archived profile URLs per Friendster URL format.

It also downloads each candidate page individually, so searching a larger number of profiles can take a while.

Some archived pages may fail to load, which is why the script reports:

```text
Couldn't retrieve: X
```

That doesn't necessarily mean the original page didn't exist.

## Why Friendster?

Because apparently I enjoy digging through the internet's archaeological layers.

Friendster disappeared a long time ago (then came back from the dead), but parts of the old site were preserved by web archiving projects.

This script is just a little tool to make exploring those archives less annoying.

## References

The project uses information and techniques based on the following resources:

* **Wayback Machine API parameters — Stack Overflow**
  https://stackoverflow.com/questions/30719213/wayback-machine-api-parameters/37799725

* **Webscraping the Wayback Machine — Stack Overflow**
  https://stackoverflow.com/questions/76596578/r-webscraping-wayback-machine

* **Searching HTML data retrieved with `Invoke-WebRequest` and Regex — Stack Overflow**
  https://stackoverflow.com/questions/57032078/search-html-data-retrieved-from-invoke-webrequest-with-regex

* **Wayback CDX Server documentation — Internet Archive**
  https://github.com/internetarchive/wayback/blob/master/wayback-cdx-server/README.md

* **Friendster — ArchiveTeam Wiki**
  https://wiki.archiveteam.org/index.php/Friendster

## Disclaimer

This project is intended for searching publicly available web archives.

It does not attempt to access Friendster accounts, bypass authentication, recover passwords, or access private information.
