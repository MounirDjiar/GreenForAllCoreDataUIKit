//
//  ProfilCreate.swift
//  Green4all
//
//  Created by Bachir SAHALI on 23/03/2021.
//

import SwiftUI

struct ProfilCreate: View {
    
    // On récupère le Managed Object Contexte pour le donner à la sheet
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var email: String = ""
    @State var password: String = ""
    @State var lastname: String = ""
    @State var firstname: String = ""
    
    @Binding var showProfilCreate:Bool
    @State var showingAlert = false


    var body: some View {
        
        // Permet de supprimer la couleur du background par defaut
        UITableView.appearance().backgroundColor = .clear
        
        // Met un background color
        UINavigationBar.appearance().backgroundColor = UIColor(Color("bgGreen"))
        
        // Couleur et fontWeight du titre de la NavBar
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor(Color.white),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs
        
        // Couleur de la navBarItems
        UINavigationBar.appearance().tintColor = .white
        
        // Couleur du background de la navBar
        UINavigationBar.appearance().barTintColor = UIColor(Color("bgGreen"))
        
        return NavigationView{
            
            ZStack{
                Color("bgGreen")
                    .ignoresSafeArea()
                VStack{
                    Form {
                        Section{
                            TextField("Prénom", text: $firstname)
                        }
                        Section{
                            TextField("Nom", text: $lastname)
                        }
                        Section{
                            TextField("Email", text: $email)
                        }
//                        Section{
//                            TextField("Mot de Passe", text: $password)
//                        }
                    }
                    .foregroundColor(Color("bgDarkGreen"))
                    .disableAutocorrection(true)
                }
                .navigationBarTitle("Créer un compte" , displayMode: .inline)
                .navigationBarItems(leading: cancelButton, trailing: addButton)
            }
        }
    }
}

extension ProfilCreate {
    
    private var cancelButton: some View {
        Button("Annuler") {
            showProfilCreate = false
        }
    }
    
    private var addButton: some View {
        Button("Créer") {
            
            if (firstname == "" || lastname == "" || email == "") {
                showingAlert = true
            }
            else {
                // On sauvegarde les données
                saveFirstUser()
                
                self.showingAlert = false
                self.showProfilCreate = false
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Attention"), message: Text("Vous devez remplir tous les champs"), dismissButton: .default(Text("OK")))
        }
    }
}

extension ProfilCreate {
    
    func saveFirstUser() {
        // On crée une nouvelle instance Projet
        let newUser = User(context: managedObjectContext)
        
        newUser.firstname = firstname
        newUser.lastname = lastname
        newUser.email = email
        
        // On save la nouvelle instance dans le MOC
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
