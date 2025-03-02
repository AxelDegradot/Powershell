$remoteComputer = "DESKTOP-0A2V37H"  # Nom ou adresse IP pour le pour le pc 
$remotePath = "\\DESKTOP-0A2V37H\c`$\Users\t.kilo\Desktop\test\Test.txt"  # Chemin réseau du fichier

if (Test-Path $remotePath) {
    $lastModified = (Get-Item $remotePath).LastWriteTime
    $name = (Get-Item $remotePath).Name

    Add-Type -AssemblyName PresentationFramework

    [System.Windows.MessageBox]::Show("Le fichier $name sur $remoteComputer a été modifié pour la dernière fois le : $lastModified", "Information", "OK", "Information")
} else {
    [System.Windows.MessageBox]::Show("Le fichier spécifié n'existe pas sur $remoteComputer. Vérifiez le chemin et l'accessibilité.", "Erreur", "OK", "Error")
}
