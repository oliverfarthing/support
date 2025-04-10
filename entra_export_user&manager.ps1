Connect-MgGraph

# Create an empty array to store user and manager data
$userManagerData = @()

# Get all users
$users = Get-MgUser -Top 999

# Get the total number of users for the progress bar
$totalUsers = $users.Count

# Loop through each user
for ($i = 0; $i -lt $totalUsers; $i++) {
    $user = $users[$i]

    # Update progress bar
    $percentComplete = (($i + 1) / $totalUsers) * 100
    Write-Progress -PercentComplete $percentComplete -Status "Processing User $($i + 1) of $totalUsers" -Activity "Retrieving Manager for $($user.UserPrincipalName)"

    # Attempt to get the manager and handle errors silently
    $manager = Get-MgUserManager -UserId $user.Id -ErrorAction SilentlyContinue

    if ($manager) {
        # Retrieve the manager's details
        $managerDetails = Get-MgUser -UserId $manager.Id -ErrorAction SilentlyContinue

        if ($managerDetails) {
            # Add a custom object with User and Manager details to the array
            $userManagerData += [PSCustomObject]@{
                UserPrincipalName = $user.UserPrincipalName
                ManagerPrincipalName = $managerDetails.UserPrincipalName
            }
        } else {
            # If no manager details are available, record that information
            $userManagerData += [PSCustomObject]@{
                UserPrincipalName = $user.UserPrincipalName
                ManagerPrincipalName = "No Manager"
            }
        }
    } else {
        # If the user does not have a manager, record that information
        $userManagerData += [PSCustomObject]@{
            UserPrincipalName = $user.UserPrincipalName
            ManagerPrincipalName = "No Manager"
        }
    }
}

# Export the data to a CSV file
$userManagerData | Export-Csv -Path ".\user_manager_data.csv" -NoTypeInformation

# Clear the progress bar once done
Write-Progress -PercentComplete 100 -Status "Completed" -Activity "Exporting Data to CSV"

Write-Host "Data exported to CSV successfully."
