//
//  ProfilPresentation.swift
//  Green4all
//
//  Created by Bachir SAHALI on 18/03/2021.
//

import SwiftUI

struct ProfilPresentation: View {
    
    // On récupère le Managed Object Contexte pour le donner à la sheet
    //@Environment(\.managedObjectContext) var context
    
    // Je récupère le current user depuis l'environement
    @EnvironmentObject var currentUser: CurrentUser
    
    var body: some View {
        HStack(alignment: .top){
          
            VStack (alignment: .leading){
                Image("avatar")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .frame(width: 200, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            VStack(alignment: .leading) {
                VStack (alignment: .leading) {
                   
                        Text("\(currentUser.user?.firstname ?? "firstname")")
                            .fontWeight(.bold)
                            .font(.system(size:20))
                        Text("\(currentUser.user?.lastname ?? "lastname")")
                            .fontWeight(.bold)
                            .font(.system(size:20))
                            .opacity(0.7)
                    
                    
                    Text("\(currentUser.user?.email ?? "email")")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                VStack(alignment: .leading) {
                    Text(" ")
                        .padding(.top, 5)
                    Text("Total investit")
                        .font(.system(size:15))
                    Text("2900" + " €")
                        .fontWeight(.bold)
                        .font(.system(size:20))
                }
            }

            
        }
        .padding(.top, 20)
        
        .foregroundColor(.white)
        .background(Color("bgGreen"))
    }
}

struct ProfilPresentation_Previews: PreviewProvider {
    static var previews: some View {
        
        // On récupère le contexte
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let user1 = User(context: context)
        user1.firstname = "Mounir"
        user1.lastname = "DJIAR"
        user1.email = "mounir@djiar.com"
        
        return ProfilPresentation()
            .environment(\.managedObjectContext, context)
            .environmentObject(CurrentUser(context: context))
    }
}
