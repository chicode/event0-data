$ethnicityData = New-Object System.Collections.ArrayList
$ethnicityData.Add(@(0,0))
$genderData = New-Object System.Collections.ArrayList
$genderData.Add(@(0,0))
$schoolsList = New-Object System.Collections.ArrayList

ForEach($entry in ConvertFrom-Csv (cat './registration responses! - Form Responses 1(1).csv')){
	if($entry.H1 -eq "CHECKED IN"){
		#Parse Ethnicity Data
		$Found = $False
		ForEach($ethnicity in $ethnicityData) {
			if($ethnicity[0] -eq $entry.ethnicity) {
				$ethnicity[1]++
				$Found = $True
			}
		}
		if($Found -eq $False) {
			$ethnicityData.Add(@($entry.ethnicity, 1))

		}
		$FoundGen = $False
		#Parse Gender Data
		ForEach($gender in $genderData) {
			if($gender[0] -eq $entry.Gender) {
				$gender[1]++
				$FoundGen=$True
				"Existing $($entry.Gender)"
			}
		}
		if($FoundGen -eq $False) {
			$genderData.Add(@($entry.gender, 1))
			"Nonexisting $($entry.gender)"
		}
		$schoolsList.Add($entry.SchoolName)
	}
}
Write-Host $genderData
ConvertTo-Json $genderData | Out-file Gender.json
ConvertTo-Json $ethnicityData | Out-File Ethnicity.json
ConvertTo-Json $schoolsList | Out-File SchoolsList.json
