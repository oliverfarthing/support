$dnsNames = @(
    ""
)

$cert = New-SelfSignedCertificate `
    -DnsName $dnsNames `
    -CertStoreLocation "Cert:\LocalMachine\My" `
    -KeyExportPolicy Exportable `
    -KeyLength 2048 `
    -KeySpec KeyExchange `
    -Provider "Microsoft RSA SChannel Cryptographic Provider" `
    -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.1") `
    -HashAlgorithm "SHA256" `
    -NotAfter (Get-Date).AddYears(10)