# Its better to test before to save an error!
# So this example is the one we will use.

# $PathToDirectory = "c:\ps-test\scripts" <- We set this in code. we then test the path to see if the directory  is present
# If it is the simple cmd end and just add the txt files.
# If the path is not present the code will create it using the new-Item
# The example shows a simple If statement

$PathToDirectory = "c:\ps-test\scripts"
If(!(test-path $PathToDirectory))
{
      New-Item -ItemType Directory -Path $PathToDirectory
}

New-Item -ItemType "file" -Force -Path "c:\ps-test\test.txt", "c:\ps-test\Logs\test1.txt" , "c:\ps-test\Logs\test2.txt"
