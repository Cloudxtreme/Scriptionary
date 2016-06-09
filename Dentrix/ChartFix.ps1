# Dentrix G5 at one of my client offices was plagued with chart issues causing numerous daily crashes.
# This simple script kills the chard, copies a clean version of the CUST folder from a share on the server
# Then restarts the chart.


Stop-Process -processname chart
Remove-Item "C:\Program Files (x86)\Dentrix\Cust" -recurse
Copy-Item "\\<PATH TO CLEAN CUST FOLDER>\Cust" "C:\Program Files (x86)\Dentrix\" -recurse
Start-Process "C:\Program Files (x86)\Dentrix\chart.exe"