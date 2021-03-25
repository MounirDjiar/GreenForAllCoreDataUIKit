//
//  ProfilConnexion.swift
//  Green4all
//
//  Created by Bachir SAHALI on 18/03/2021.
//

import SwiftUI

struct ProfilConnexion: View {
    
    // On récupère le Managed Object Contexte pour le donner à la sheet
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    @State var mail: String = ""
    @State var password: String = ""
    @State var showProfilCreate:Bool = false
    @State var connected:Bool = false
    
    
    init(){
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().largeTitleTextAttributes =
            [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
             
        if (!connected) {
            ZStack {
                Color("bgGreen")
                    .ignoresSafeArea()
                
                VStack{
                    Form {
                        Section{
                            TextField("Email", text: $mail)
                        }
//                        Section{
//                            SecureField("Mot de Passe", text: $password)
//                            
//                        }
                    }
                    .foregroundColor(Color("bgDarkGreen"))
                    .frame(maxHeight: 170)
                    .onAppear{
                        UITableView.appearance().backgroundColor = .clear
                    }
                     
                    VStack( spacing: 100){
                        
//                        Button(action: {}, label: {
//                            Text("Mot de Passe oublié ?")
//                                .fontWeight(.bold)
//                        })
                        
                        Button(action: {
                            connected.toggle()
                        }, label: {
                            Text("Se Connecter")
                                .fontWeight(.bold)
                        })
                        .padding(.horizontal, 100)
                        .padding()
                        .background(Color("bgDarkGreen"))
                        .cornerRadius(10)
                        
                        Button(action: {
                           showProfilCreate = true
                        }, label: {
                            HStack {
                                Text("Pas de compte ?" )
                                Text("Inscrivez-vous")
                                    .fontWeight(.bold)
                            }
                        })
                    }
                }
                
            }
            .foregroundColor(.white)
            .navigationBarTitle("Connexion" , displayMode: .large)
            
            // La modale addProject
            .sheet(isPresented: $showProfilCreate, content: {
                ProfilCreate(showProfilCreate: $showProfilCreate)
                    .environment(\.managedObjectContext, managedObjectContext)
            })
        } else {
            TabBar()
                .environment(\.managedObjectContext, managedObjectContext)
                // Je le rajoute à l'environement
                .environmentObject(CurrentUser(context: managedObjectContext))
        }
    }}

struct ProfilConnexion_Previews: PreviewProvider {
    static var previews: some View {
        ProfilConnexion()
    }
}
