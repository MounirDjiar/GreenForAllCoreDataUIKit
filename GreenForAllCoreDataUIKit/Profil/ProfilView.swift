//
//  ProfilView.swift
//  Green4all
//
//  Created by Bachir SAHALI on 18/03/2021.
//

import SwiftUI

struct ProfilView: View {
    
    // On récupère tous les projet
    @FetchRequest(fetchRequest: Project.fetchRequest()) var projects:FetchedResults<Project>
    
//    @FetchRequest(
//        entity: Project.entity(),
//        sortDescriptors: [],
//        predicate: NSPredicate(format: "title == 'Project 2'")
//    ) var projects: FetchedResults<Project>
//
//
//
//
//
//
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
                    
                    
                    VStack(alignment: .leading) {
                        Section(
                            header: Text("Mes projets")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(.white)
                        ) {
                            TabView {
                                ForEach (projects) { project in
                                    ProjectRow(project: project)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle())
                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Section(
                            header: Text("Mes contributions")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(.white)
                        ) {
                            TabView {
                                ForEach (projects) { project in
                                    ProjectRow(project: project)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle())
                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                        }
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

struct ProfilView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        // On récupère le contexte
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // On crée une instance de Project
        let project1 = Project(context: context)
        
        // On lui assigne des valeurs
        project1.title = "Projet 1"
        project1.budget = 12000
        project1.picture = "icon_project1"
        project1.category = CategoryProject.energie.rawValue
        project1.created_date = Date()
        project1.description_project = "Description du projet"
        
        // Creation du User
        let user1 = User(context: context)
        user1.firstname = "Mounir"
        user1.lastname = "DJIAR"
        user1.email = "mounir@djiar.com"
        project1.user = user1
        
        return ProfilView()
            .environmentObject(CurrentUser(context: context))
    }
}
