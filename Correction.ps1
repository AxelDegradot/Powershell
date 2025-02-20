$nomUtilisateur = Read-Host "Entre le nom de l'utilisateur"

#Fonction pour l'affichage du Menu
Function Afficher-menu {

#Verifier si l'utilisateur existe dans l'active directory
$user = Get-ADUser -Filter {SamAccountName -eq $nomUtilisateur} -ErrorAction SilentlyContinue

#Recuperer l'etat actuel du compte
$utilisateur = Get-ADUser -Identity $nomUtilisateur -Properties Enabled

If ($user) {
#Affichage du Menu
    Write-Host "Veuillez Sélectionner une option :" -ForegroundColor Red 
    Write-Host "1. Désactiver le compte"-ForegroundColor White
    Write-Host "2. Activer le Compte" -ForegroundColor White
    Write-Host "3. Changer d'utilisateur" -ForegroundColor White
    Write-Host "4. Activer ou Désactiver le compte" -ForegroundColor White
    Write-Host "5. Quitter" -ForegroundColor White

# Demander la sélection
$choix = Read-Host "Entre le numero de l'option"

# Agir selon le choix
Switch ($choix) {
    "1" {
        Write-Host "Option 1 sélectionnée : Désactiver le compte" -ForegroundColor Red
        Disable-ADAccount -Identity $nomUtilisateur
        Write-Host "L'utilisateur sélectionner a bien etait Désactiver" -ForegroundColor Red
        # Code pour desactiver le compte
        break

    }
    "2" {
        Write-Host "Option 2 sélectionnée : Activer le Compte" -ForegroundColor Green
        Enable-ADAccount -Identity $nomUtilisateur
        Write-Host "L'utilisateur sélectionner a bien etait Activer" -ForegroundColor Green
        #code pour activer le compte
        break
   }
   "3" {
        Write-Host "option 3 sélectionnée : Changer d'utilisateur" -ForegroundColor White
        $nomUtilisateur = Read-Host "Entre le nom de l'utilisateur a désactiver ou a activer"
        Write-Host "Vous venez de Changer d'utilisateur" -ForegroundColor White
        Afficher-Menu
         break
   }

    "4" {
    Write-Host "Option 4 Sélectionnée : Activer ou Désactiver le compte selon son etat"-ForegroundColor White
   $utilisateur = Get-ADUser -Identity $nomUtilisateur -Properties Enabled

     if ($utilisateur.enabled -eq $true ) {

       Disable-ADAccount -Identity $nomUtilisateur

       Write-Host "Votre compte Activer vient d'etre Desactiver" -ForegroundColor Red

    } else {
    Enable-ADAccount -Identity $nomUtilisateur
    Write-Host "Votre compte Desactiver vient d'etre Activer" -ForegroundColor Green
    break
    }
   }

   "5" {
        Write-Host "option 5 sélectionnée : Quitter" -ForegroundColor White
        Write-Host "Vous venez de quitter" -ForegroundColor RED
        break
   }
    
    

  }
   
  }else{
    Write-Host "utilisateur $nomUtilisateur n'a pas ete trouvé dans l'Active Directory" -ForegroundColor Red
    break
 
}
}

#Appel initial de la fonction pour afficher le menu
Afficher-Menu