# Import du module Active Directory
Import-Module ActiveDirectory

# Fichier source CSV
$FichierCSV = "C:\Scripts\Utilisateurs.csv"

# Fichier rapport
$RapportCSV = "C:\Scripts\Rapport_AD.csv"

# Tableau pour le rapport
$Rapport = @()

# Lecture du fichier CSV
$Utilisateurs = Import-Csv -Path $FichierCSV -Delimiter ";"

foreach ($User in $Utilisateurs) {

    try {

        # Vérifier si l'utilisateur existe déjà
        $Existe = Get-ADUser -Filter "SamAccountName -eq '$($User.Login)'" -ErrorAction SilentlyContinue

        if ($Existe) {

            $Rapport += [PSCustomObject]@{
                Login  = $User.Login
                Statut = "Déjà existant"
                Groupe = $User.Groupe
                Date   = Get-Date
            }

            continue
        }

        # Création du compte
        New-ADUser `
            -Name "$($User.Prenom) $($User.Nom)" `
            -GivenName $User.Prenom `
            -Surname $User.Nom `
            -SamAccountName $User.Login `
            -UserPrincipalName "$($User.Login)@entreprise.local" `
            -Path $User.OU `
            -AccountPassword (ConvertTo-SecureString $User.MotDePasse -AsPlainText -Force) `
            -Enabled $true `
            -ChangePasswordAtLogon $true

        # Ajout au groupe de sécurité
        Add-ADGroupMember `
            -Identity $User.Groupe `
            -Members $User.Login

        $Rapport += [PSCustomObject]@{
            Login  = $User.Login
            Statut = "Créé avec succès"
            Groupe = $User.Groupe
            Date   = Get-Date
        }
    }
    catch {

        $Rapport += [PSCustomObject]@{
            Login  = $User.Login
            Statut = "Erreur : $($_.Exception.Message)"
            Groupe = $User.Groupe
            Date   = Get-Date
        }
    }
}

# Export du rapport
$Rapport | Export-Csv `
    -Path $RapportCSV `
    -NoTypeInformation `
    -Encoding UTF8 `
    -Delimiter ";"

Write-Host ""
Write-Host "Traitement terminé."
Write-Host "Rapport généré : $RapportCSV"
