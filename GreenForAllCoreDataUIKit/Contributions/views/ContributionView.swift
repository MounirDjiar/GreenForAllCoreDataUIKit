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
    
    @Binding var showContributionView:Bool
    @State var amount:String = ""
    
    var project:Project
    
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
        
        return ZStack {
            Color("bgGreen").ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Veuillez saisir le montnat de votre contribution")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                Form {
                    TextField("Montant", text: $amount).keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 200, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Spacer()
                    Button("Annuler") {
                        showContributionView = false
                    }
                    .font(.title)
                    .frame(width: 100)
                    .padding(8.0)
                    .background(Color.white)
                    .cornerRadius(8)
                    
                    Spacer()
                    
                    Button("Valider") {
                        saveAmount()
                    }
                    .font(.title)
                    .frame(width: 100)
                    .padding(8.0)
                    .background(Color.white)
                    .cornerRadius(8)
                    
                    Spacer()
                    
                }.foregroundColor(Color("greenSearchBar"))
            }
        }
    }
}

extension ContributionView {
    
    private func saveAmount() {
       
        if let montant = (Int(amount)) {
            let newContribution = Contribution(context: managedObjectContext)
            newContribution.amount = Int64(montant)
            project.addToContributions(newContribution)
            
            // On save la nouvelle instance dans le MOC
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
        showContributionView = false
    }
}

/*
struct ContributionView_Previews: PreviewProvider {
    static var previews: some View {
        
        // On récupère le contexte
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return ContributionView(showContributionView: .constant(true))
            .environment(\.managedObjectContext, context)

    }
}
 */
