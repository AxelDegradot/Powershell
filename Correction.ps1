$nomUtilisateur = Read-Host "Entre le nom de l'utilisateur"

#Fonction pour l'affichage du Menu
Function Afficher-menu {

#Verifier si l'utilisateur existe dans l'active directory
$user = Get-ADUser -Filter {SamAccountName -eq $nomUtilisateur} -ErrorAction SilentlyContinue

#Recuperer l'etat actuel du compte
$utilisateur = Get-ADUser -Identity $nomUtilisateur -Properties Enabled

If ($user) {
#Affichage du Menu
    Write-Host "Veuillez Sélectionner une option :" 
    Write-Host "1. Désactiver le compte"
    Write-Host "2. Activer le Compte" 
    Write-Host "3. Changer d'utilisateur" 
    Write-Host "4. Activer ou Désactiver le compte" 
    Write-Host "5. Quitter" 

# Demander la sélection
$choix = Read-Host "Entre le numero de l'option"

# Agir selon le choix
Switch ($choix) {
    "1" {
        Write-Host "Option 1 sélectionnée : Désactiver le compte" 
        Disable-ADAccount -Identity $nomUtilisateur
        Write-Host "L'utilisateur sélectionner a bien etait Désactiver" 
        # Code pour desactiver le compte
        break

    }
    "2" {
        Write-Host "Option 2 sélectionnée : Activer le Compte" 
        Enable-ADAccount -Identity $nomUtilisateur
        Write-Host "L'utilisateur sélectionner a bien etait Activer" 
        #code pour activer le compte
        break
   }
   "3" {
        Write-Host "option 3 sélectionnée : Changer d'utilisateur" 
        $nomUtilisateur = Read-Host "Entre le nom de l'utilisateur a désactiver ou a activer"
        Write-Host "Vous venez de Changer d'utilisateur" 
        Afficher-Menu
         break
   }

    "4" {
    Write-Host "Option 4 Sélectionnée : Activer ou Désactiver le compte selon son etat"
   $utilisateur = Get-ADUser -Identity $nomUtilisateur -Properties Enabled

     if ($utilisateur.enabled -eq $true ) {

       Disable-ADAccount -Identity $nomUtilisateur

       Write-Host "Votre compte Activer vient d'etre Desactiver" 

    } else {
    Enable-ADAccount -Identity $nomUtilisateur
    Write-Host "Votre compte Desactiver vient d'etre Activer" 
    break
    }
   }

   "5" {
        Write-Host "option 5 sélectionnée : Quitter" 
        Write-Host "Vous venez de quitter" 
        break
   }
    
    

  }
   
  }else{
    Write-Host "utilisateur $nomUtilisateur n'a pas ete trouvé dans l'Active Directory" 
    break
 
}
}

#Appel initial de la fonction pour afficher le menu
Afficher-Menu
