//
//  ProfilView.swift
//  Green4all
//
//  Created by Bachir SAHALI on 18/03/2021.
//

import SwiftUI

struct ProfilView: View {
    
    // On récupère le Managed Object Contexte pour le donner à la sheet
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // Je récupère le current user depuis l'environement
    @EnvironmentObject var currentUser: CurrentUser
    
    var fetchRequestMyProjects: FetchRequest<Project>
    var myProjects: FetchedResults<Project> {fetchRequestMyProjects.wrappedValue}
    
    var fetchRequestMyProjectsContributions: FetchRequest<Project>
    var myContributions: FetchedResults<Project> {fetchRequestMyProjectsContributions.wrappedValue}
    
    init (currentUser: CurrentUser) {
        
        fetchRequestMyProjects = FetchRequest<Project>(entity: Project.entity(),
                                                       sortDescriptors: [],
                                                       predicate: NSPredicate(format: "user.firstname == '\(currentUser.user?.firstname ?? "")'"))
        
        
        fetchRequestMyProjectsContributions = FetchRequest<Project>(entity: Project.entity(),
                                                                    sortDescriptors: [],
                                                                    predicate: NSPredicate(format: "ANY contributions.user.firstname == '\(currentUser.user?.firstname ?? "")'"))
    }
    
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
        
        return NavigationView {
            ZStack{
                Color("bgGreen")
                    .ignoresSafeArea()
                
                VStack(alignment: .leading){
                    
                    ProfilPresentation()
                    
                    List  {
                        Section(
                            header: Text("Mes projets")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(.white)
                        ) {
                            if (!myProjects.isEmpty) {
                                TabView {
                                    ForEach (myProjects) { project in
                                        ProjectRow(project: project)
                                    }
                                }
                                .tabViewStyle(PageTabViewStyle())
                                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                            } else {
                                HStack {
                                    Text("Vous n'avez aucun projet")
                                        .foregroundColor(.white)
                                }
                                Spacer()
                            }
                        }
                        
                        Section(
                            header: Text("Mes contributions")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(.white)
                        ) {
                            if (!myContributions.isEmpty) {
                                TabView {
                                    ForEach (myContributions) { project in
                                        ProjectRow(project: project)
                                    }
                                }
                                .tabViewStyle(PageTabViewStyle())
                                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                            } else {
                                HStack {
                                    Text("Vous n'avez aucune contribution")
                                        .foregroundColor(.white)
                                }
                                Spacer()
                            }
                        }
                        .listRowBackground(Color("bgGreen"))
                    }
                    
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Profil")
            
        }
        .accentColor(.white)
    }
}

//struct ProfilView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        
//        // On récupère le contexte
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        
//        // On crée une instance de Project
//        let project1 = Project(context: context)
//        
//        // On lui assigne des valeurs
//        project1.title = "Projet 1"
//        project1.budget = 12000
//        project1.picture = "icon_project1"
//        project1.category = CategoryProject.energie.rawValue
//        project1.created_date = Date()
//        project1.description_project = "Description du projet"
//        
//        // Creation du User
//        let user1 = User(context: context)
//        user1.firstname = "Mounir"
//        user1.lastname = "DJIAR"
//        user1.email = "mounir@djiar.com"
//        project1.user = user1
//        
//        return ProfilView()
//            //.environment(\.managedObjectContext, context)
//            .environmentObject(CurrentUser(context: context))
//    }
//}
