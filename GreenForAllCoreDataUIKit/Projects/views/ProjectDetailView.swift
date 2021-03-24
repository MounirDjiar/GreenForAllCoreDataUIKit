//
//  ProjectDetailView.swift
//  Green4all
//
//  Created by Mounir DJIAR on 18/03/2021.
//

import SwiftUI

struct ProjectDetailView: View {
  
    // On récupère le Managed Object Contexte pour le donner à la sheet
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // Je récupère le current user depuis l'environement
    @EnvironmentObject var currentUser: CurrentUser
    
    let project:Project
    
    @State private var showContributionView:Bool = false
    
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
        
        // NAVIGATION
        return ZStack {
            // La couleur du background
            Color("bgGreen").ignoresSafeArea()
            
            VStack(alignment: .leading){
                HStack {
                    Image(project.picture)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(5.0)
                        .overlay(
                            HStack {
                                Text("\(CategoryProject(rawValue: project.category)!.categoryProjectTitle)")
                                    .font(.headline)
                            }
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color("progressBarColor"))
                            .cornerRadius(15.0)
                            .padding(.vertical, -10)
                            .padding(.horizontal, -10)
                            .shadow(radius: 10)
                            , alignment: .bottomTrailing
                        )
                }
                
                HStack {
                    VStack (alignment: .leading) {
                        Text("Avancement du projet")
                            .font(.headline)
                            .fontWeight(.bold)
                        ProgressBar(
                            value: project.progressContributions,
                            filColor:Color("progressBarColor"),
                            bgColor: Color.white
                        )
                        .frame(height: 30)
                    }//:VStack
                    
                }//:HStack
                .padding(.vertical)
                
                HStack {
                    VStack {
                        HStack(alignment: .top) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 25))
                            Text("\(project.nbContributeurs)")
                                .fontWeight(.bold)
                                .font(.system(size: 25))
                                .padding(.leading, -8.0)
                        }
                        Text("Contributeurs")
                            .font(.system(size: 14))
                    }
                    
                    Spacer()
                    VStack {
                        HStack {
                            Image(systemName: "clock.arrow.circlepath")
                                .font(.system(size: 25))
                            Text("\(project.nbDaysLeftToProject)")
                                .fontWeight(.bold)
                                .font(.system(size: 25))
                                .padding(.leading, -8.0)
                        }
                        Text("Jours restants")
                            .font(.system(size: 14))
                    }
                    
                    Spacer()
                    VStack {
                        HStack {
                            Image(systemName: "eurosign.circle")
                                .font(.system(size: 25))
                            Text("\(project.budget)€")
                                .fontWeight(.bold)
                                .font(.system(size: 25))
                                .padding(.leading, -9.0)
                        }
                        Text("Budget")
                            .font(.system(size: 14))
                    }
                    
                }//:HStack
                .padding(.vertical)
                
                VStack {
                    Text(project.description_project)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(10)
                    
                }
                
                if (canContribute()) {
                    HStack {
                        Spacer()
                        Button(action: {
                            contribute()
                        }, label: {
                            Text("Contribuer")
                                .font(.system(size: 25))
                                .frame(width: 200)
                                .padding(8.0)
                                .background(Color("progressBarColor"))
                                .cornerRadius(8)
                        })
                        
                        Spacer()
                    }
                    .padding(.vertical)
                }
                                
                Spacer()
                
            }//:VStack
            .padding(.horizontal)
            .foregroundColor(.white)
            
        }//:ZStack
        .navigationBarTitle(project.title)
        
        
        // La modale pour la contribution
        .sheet(isPresented: $showContributionView, content: {
            ContributionView(showContributionView: $showContributionView, project: project)
                .environment(\.managedObjectContext, managedObjectContext)
        })
    }
}

extension ProjectDetailView {
    private func contribute() {
        showContributionView = true
    }
    
    private func canContribute() -> Bool {
        
        if (currentUser.user != project.user) {
            return true
        }
        return false
        
    }
}

struct ProjectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        // On récupère le contexte
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Instanciation CurrentUser
        let currentUser = CurrentUser(context: context)
        
        // On crée une instance de Project
        let project1 = Project(context: context)
        
        // On lui assigne des valeurs
        project1.title = "Projet 1"
        project1.description_project = """
            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.
            """
        project1.budget = 12000
        project1.picture = "Icon_project2"
        project1.category = CategoryProject.energie.rawValue
        project1.created_date = Date()
        project1.finished_date = Date().addingTimeInterval(TimeInterval(86400 * 6)) // Exemple 6J

        
        // Le user créateur du projet
        let user1 = User(context: context)
        user1.firstname = "Djallal"
        user1.lastname = "DJIAR"
        project1.user = user1
        
        // Je crée une contribution
        let contribution1 = Contribution(context: context)
        contribution1.amount = 1000
        
        // Je crée une contribution
        let contribution2 = Contribution(context: context)
        contribution2.amount = 2000
        
        project1.addToContributions(contribution1)
        project1.addToContributions(contribution2)

        
        return ProjectDetailView(project: project1)
            .environment(\.managedObjectContext, context)
            .environmentObject(currentUser)
    }
}
