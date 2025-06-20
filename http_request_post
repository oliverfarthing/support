# Step 1: Get an access token
$token = (Get-AzAccessToken -ResourceUrl "https://vault.azure.net").Token

# Step 2: Define headers and endpoint
$headers = @{
    "Authorization" = "Bearer $token"
}

$url = "https://example.net/secrets?api-version=7.4"

# Step 3: Make the REST call
$response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers

# Step 4: Display secret names
$response.value | ForEach-Object { $_.id }
