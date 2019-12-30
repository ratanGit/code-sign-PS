function MakeMySignCert{
    <#
    .SYNOPSIS
        Creates a self-signed certificate to sign your PowerShell scripts.
    .DESCRIPTION
        Codesigning a script allows you white list the CodeSigning Certificate and to run the script on remote machines
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
    .PARAMETER User
        $yourEmail is stroed in the CN field of certificate   
    .EXAMPLE
        MakeMySignCert -yourEmail 'me@myemail.edu'
    .NOTES
        Author: Ratan Mohapatra | https://www.linkedin.com/in/ratanm/
        Last Update: December 30, 2019 
    #>
    [CmdletBinding()]
    param(
        [string]$yourEmail
        )
    $cnString = 'CN=' + $yourEmail
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_signing?view=powershell-6
    New-SelfSignedCertificate -CertStoreLocation cert:\currentuser\my `
    -Subject $cnString `
    -KeyAlgorithm RSA `
    -KeyLength 2048 `
    -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" `
    -KeyExportPolicy Exportable `
    -KeyUsage DigitalSignature `
    -Type CodeSigningCert

    #list certs in my cert dir
    write-host -BackgroundColor Green -ForegroundColor White "`nYou have the following Code Signing Certs available!"
    dir cert:\currentuser\my -CodeSigningCert
    }
