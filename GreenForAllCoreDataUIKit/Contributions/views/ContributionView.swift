//
//  ContributionView.swift
//  GreenForAllCoreDataUIKit
//
//  Created by Mounir DJIAR on 23/03/2021.
//

import SwiftUI

struct ContributionView: View {
    
    // On récupère le Managed Object Contexte
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // Je récupère le current user depuis l'environement
    @EnvironmentObject var currentUser: CurrentUser
    
    @Binding var showContributionView:Bool
    @State var amount:String = ""
    
    @ObservedObject var project:Project
    
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
        
        // Passer a false si on ne veut que la couleur de la navBar soit translucide
        //UINavigationBar.appearance().isTranslucent = false
        
        return  NavigationView {
            
            ZStack {
                Color("bgGreen").ignoresSafeArea()
                
                VStack(alignment: .center) {
                    Spacer()
                    HStack {
                        Text("Quel est le montant de votre contribution ?")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    Form {
                        TextField("Montant", text: $amount).keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("bgGreen"))
                    } .frame(maxHeight: 150)
                    
                    Button(action: {
                        saveAmount()
                        showContributionView = false
                        
                    }, label: {
                        Text("Payer")
                            .fontWeight(.bold)
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal, 135)
                    .padding()
                    .background(Color("bgDarkGreen"))
                    .cornerRadius(10)
                    Spacer()
                }
            }
            .navigationBarItems(trailing: Button(action: {showContributionView = false}, label: {
                Image(systemName: "multiply")
                    .font( .system(size: 25))
            }))
            .foregroundColor(.white)
        }
    }
}

extension ContributionView {
    
    private func saveAmount() {
       
        if let montant = (Int(amount)) {
            let newContribution = Contribution(context: managedObjectContext)
            newContribution.amount = Int64(montant)
            newContribution.user = currentUser.user
            project.addToContributions(newContribution)
            
            // On save la nouvelle instance dans le MOC
            do {
                print(newContribution.description)
                
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
        showContributionView = false
    }
}
