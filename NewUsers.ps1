# Author: Enoch Masih
# Class: Networks II 
# Date Created: 11/21/2020
# The purpose of this program is to learn about powershell scripting by creating users in a Acitve-Directory. 
# The following are functions that the script uses.

Function main_menu #This Function provides the user option to either create or remove a user.
{
clear
Write-Host "========================="
Write-Host " Enoch's User-management"
Write-Host "========================="
Write-Host "1. Create User."
Write-Host "2. Remove User."
Write-Host "3. Get User Details.`n"
$choice = Read-Host -Prompt 'Enter 1, 2, or 3 to select the option above'
if ($choice -eq 1)
{
    user_script
}
elseif ($choice -eq 2)
{
    remove
}
elseif ($choice -eq 3)
{
    verify
}
else
{
    Write-Host "`nPlease Enter the digit '1' or '2' or '3'. Try again."
    start-sleep -s 5
    main_menu 
}
}
Function user_script #This Function will create the user.
{
$number = Read-Host -Prompt "Enter the amount of users you want to create (Enter an Interger)"
if ($number -match "^\d+$") # This is a check to make sure the user enters a Integer and not string or float using regex.
{
    Write-Host "`nLet's Begin!`n"
}
else 
{
    Write-Host ">>>Please Enter a whole number greater than zero using the numeric keys. Try Again.<<<`n"
    start-sleep -s 5
    main_menu #The user is brought back to the main menu and can try again. 
}
Do 
{
    if ($number -gt 0) #if zero is passed in prevents the script from running
    {
        Write-Host "$number users to go."
        $number = $number - 1
        $name = Read-Host -Prompt 'Enter the NAME'
        $givenName = Read-Host -Prompt 'Enter the GIVEN NAME'
        $surName = Read-Host -Prompt 'Enter the SURNAME'
        $usrprinName = Read-Host -Prompt 'Enter the USER PRINCIPAL NAME'
        $samaccName = Read-Host -Prompt 'Enter the SAM ACCOUNT NAME'
        New-ADUser -Name "$name" -GivenName $givenName -Surname $surName -UserPrincipalName $usrprinName -SamAccountName $samaccName
        $newPW = Read-Host "Enter the new password (Make it long and complex)." -AsSecureString
        Set-ADAccountPassword $samaccName -NewPassword $newPW
        Enable-ADAccount $samaccName
        Write-Host "`nAccount Created! Check it out.`n"
        Get-ADUser $samaccName
    }
    else
    {
        Write-Host "you cannot create Zero number of users. Try Again."
        start-sleep -s 5
        main_menu
    }
}while ($number -gt 0)
Write-Host "`nDone! Returning to Main Menu."
start-Sleep -s 10
main_menu
}
Function remove #This Function will remove the user
{
$user_remove = Read-Host 'Enter the Sam Account Name of the user you want to delete'
Remove-ADUser $user_remove
Write-Host "`nDone!"
start-Sleep -s 5
main_menu
}
Function verify
{
$verify_user = Read-Host 'Enter the Sam Account Name of the user'
Get-ADUser $verify_user
start-Sleep -s 10
main_menu
}

main_menu