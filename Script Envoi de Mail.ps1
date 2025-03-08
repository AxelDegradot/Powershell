
$remoteComputer = "SRV-DATA"  # Nom ou adresse IP du PC distant


$FilePath = @(
    #"\\SRV-GEOLANE\E-LLIANCE\BASE ARTICLE.csv"  # Chemin réseau du fichier spécifique
    #"\\SRV-GEOLANE\E-LLIANCE\BASE PRODUIT.csv"
    #"\\SRV-GEOLANE\E-LLIANCE\BASE VL.csv"
    "\\SRV-DATA\adegradot$\COMMANDE AMAZON.docx"
    "\\SRV-DATA\adegradot$\Mesure Cyber a effectuer.txt"
    "\\SRV-DATA\adegradot$\TEST2.txt"
)

#$lastModified = (Get-Item $file).LastWriteTime
#$name = (Get-Item $file).Name

foreach ($file in $FilePath) {
$lastModified = (Get-Item $file).LastWriteTime
$name = (Get-Item $file).Name

if ((Get-Date).ToShortDateString()  -ne $lastModified.ToShortDateString()){

 $htmlBody = @"
 <html>
    <body>
        <h2>Attention : Mise à jour du fichier $name échouée</h2>
        <p>Le fichier <strong>$name</strong> n'a pas été mis à jour comme prévu. Veuillez vérifier les logs ou les processus associes pour résoudre ce problème.</p>
        <p>Merci de votre attention.</p>
    </body>
</html>
 </html>
"@  # Corps du message en HTML
# Définir les paramètres de l'email
$smtpServer = "mail1.sfrbusinessteam.fr"  # Remplacer par l'adresse de ton serveur SMTP
$fromAddress = "e-lliance@soparco.com"  # Remplacer par ton adresse email
$toAddress = "a.degradot@soparco.com" , "d.pelops@soparco.com"  # Remplacer par l'adresse du destinataire
$subject = "Attention : Mise à jour des fichiers Geolane a echouée"

# Envoi du mail avec le corps HTML
Send-MailMessage -From $fromAddress -To $toAddress -Subject $subject -Body $htmlBody -BodyAsHtml -SmtpServer $smtpServer -Encoding ([System.Text.Encoding]::UTF8)
}
}
