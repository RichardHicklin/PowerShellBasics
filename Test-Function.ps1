Function Test-Function {


[cmdletbinding()]
param (
        [Parameter( Position=0,Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][string]$PathToDirectory,

        [Parameter( Position=1,Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$true)][string[]]$Files,

        [Parameter( Position=2,Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][string]$RenameExtValue

	   )
Begin {
        # Start StopWatch for timing
        $Stopwatch = [system.diagnostics.stopwatch]::startNew()
        # Out Put start of script
        write-host -ForegroundColor Green "================================"
        write-host -ForegroundColor Green "Start of Function Test-Function "
        write-host -ForegroundColor Green "================================"
      }
Process{
        # Verbose output for testing
		write-verbose "Params passed in"
		Write-Verbose "Path to folder: $PathToDirectory,"
		Write-Verbose "Files: $Files"
		Write-Verbose "File Extension: $RenameExtValue"

        # Setup Folder Structure
        IF(!(Test-Path -Path "$PathToDirectory" )){
		New-Item -ItemType directory -Path $PathToDirectory
		Write-Host "New folder created"
        }
        ELSE{
            Write-Host "Folder already exists"
			}
			# Create Files
            $Files.Split(",")
            foreach ($Item in $Files){
            new-item -ItemType "File" -Path $PathToDirectory\$Item -Force
            }
            
            # Do download for each item found with the FileExtension
            CD $PathToDirectory
            $DirectoryOfFiles = $PathToDirectory = Get-ChildItem
		        FOREACH ($Item in $DirectoryOfFiles){
			      Write-Host "Item is named: $Item"
            $filenew = $Item.Name.split('\.')[-2] + "$RenameExtValue"
            Rename-Item -Path "$Item" "$filenew" -Force
			      }
		  }
END {
	# Stop Stopwatch and report duration and completed status to screen and logfile.
	$Stopwatch.stop()

	# Out Put end of Function
	write-host -ForegroundColor Green "===================="
	write-host -ForegroundColor Green "End of Function"
	write-host -ForegroundColor Green "===================="

	$tmpstring = "Duration: $(($Stopwatch.Elapsed).ToString())"
	Write-Host -ForegroundColor Green $tmpstring
    }
}
