$ethnicityData = New-Object System.Collections.ArrayList
$ethnicityData.Add(@(0,0))
$genderData = New-Object System.Collections.ArrayList
$genderData.Add(@(0,0))
$schoolsList = New-Object System.Collections.ArrayList
$abilityData = New-Object System.Collections.ArrayList
$abilityData.Add(@(0,0))
$interestData = New-Object System.Collections.ArrayList
$interestData.Add(@(0,0))



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
			}
		}
		if($FoundGen -eq $False) {
			$genderData.Add(@($entry.gender, 1))
		}
		$schoolsList.Add($entry.SchoolName)
		
		$interests = "['$($entry.interests.Replace(",","','"))']"
		$interests = $interests.Replace(" ", "")
		$interests = ConvertFrom-Json $interests
		
		ForEach($interest in $interests) {
			$FoundInt = $False
			ForEach($storedInterest in $interestData) {
				if($interest -eq $storedInterest[0]) {
					$storedInterest[1]++
					$FoundInt = $True
				}
			}
			if($FoundInt -eq $False) {
				$InterestData.Add(@($interest, 1))
			}
		}

		
		$FoundAbl = $False
                ForEach($ability in $abilityData) {
                        if($ability[0] -eq $entry.ability) {
                                $ability[1]++
                                $FoundAbl = $True
                        }
                }
                if($FoundAbl -eq $False) {
                        $abilityData.Add(@($entry.ability,1))
                }


	}
}
Write-Host $genderData
ConvertTo-Json $interestData | Out-File interest.json
ConvertTo-Json $abilityData | Out-File ability.json
ConvertTo-Json $genderData | Out-file Gender.json
ConvertTo-Json $ethnicityData | Out-File Ethnicity.json
ConvertTo-Json $schoolsList | Out-File SchoolsList.json
