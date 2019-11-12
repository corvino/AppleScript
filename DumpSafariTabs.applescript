set home to get path to home folder as string
set computerName to do shell script "scutil --get ComputerName"
set dateString to do shell script "date '+%Y.%m.%d-%H.%M'"
set fileName to home & "Dropbox:notes:links:" & computerName & "-" & dateString & ".org"

log "Writing safari tabs to " & fileName

tell application "Safari"

	set docText to ""
	set windowCount to number of windows

	repeat with w from 1 to windowCount
		set tabcount to number of tabs in window w

		repeat with t from 1 to tabcount
			set tabName to name of tab t of window w
			set tabURL to URL of tab t of window w

			set docText to docText & Â
				"[[" & tabURL & "][" & tabName & "]]" & Â
				linefeed as string
		end repeat
	end repeat


	set dumpFile to open for access fileName with write permission
	write docText to dumpFile
	close access dumpFile
end tell
