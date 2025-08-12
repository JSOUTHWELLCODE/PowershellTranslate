
$apiKey = 'Your api key'
$endpoint = 'https://api.cognitive.microsofttranslator.com' 
#$region = 'francecentral'
$toLanguage = "fr"

$Stringtotranslate = Read-Host -Prompt "Enter a sentence to be translated"

# Request body formatted correctly as a JSON object
<#$requestBody = @(
    @{
        "Text" = $Stringtotranslate
    }
)#>

#$jsonBody = $requestBody | ConvertTo-Json
$jsonBody = "[{""Text"":""$Stringtotranslate""}]"

# Construct the URI
$uri = "$endpoint/translate?api-version=3.0&to=$toLanguage"

# Set headers correctly
$headers = @{
    "Ocp-Apim-Subscription-Key" = $apiKey
   # "Ocp-Apim-Subscription-Region" = $region
    "Content-Type" = "application/json"
}

Write-Host "API Key: $apiKey"
#Write-Host "Region: $region"
Write-Host "URI: $uri"
Write-Host "JSON Body: $jsonBody"

# Invoke the API
try {
    $translationResult = Invoke-RestMethod -Method Post -Uri $uri -Headers $headers -Body $jsonBody
    $translatedText = $translationResult[0].translations[0].text

    Write-Host "Original: $Stringtotranslate"
    Write-Host "Translated: $translatedText"
} catch {
    Write-Host "An error occurred during the API call."
    Write-Host "Error Message: $($_.Exception.Message)"
    Write-Host "Please check your API Key, Region, and Endpoint."
}
