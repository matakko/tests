
$emusPath = "D:\test2"
$emulationPath = "C:\test1"

function createSaveLink($target, $linkPath) {
    if (Test-Path $linkPath) {
        Remove-Item -Path $linkPath -Force
    }

    New-Item -ItemType SymbolicLink -Path $linkPath -Target $target
	
}
function test_1(){

$emupathsave = "$emusPath\toto"
$savelink = "$emulationPath\tata"

createSaveLink $emupathsave $savelink

}
function test_2(){

$emupathsave = "$emusPath\momo"
$savelink = "$emulationPath\mama"

createSaveLink $emupathsave $savelink
}

    test_1
	
    test_2
