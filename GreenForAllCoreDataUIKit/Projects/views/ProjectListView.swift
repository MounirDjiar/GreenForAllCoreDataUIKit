//
//  ProjectListView.swift
//  GreenForAllCoreDataUIKit
//
//  Created by Mounir DJIAR on 21/03/2021.
//

import SwiftUI

struct ProjectListView: View {
    
    // On récupère le Managed Object Contexte pour le donner à la sheet
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // On récupère les données stockées
    @FetchRequest(fetchRequest: Project.fetchRequest()) var projects:FetchedResults<Project>
    
    @State var searchText: String = ""
    @State var showAddProjectView:Bool = false
    
    var body: some View {
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // NAVIGATION
        return NavigationView {
            ZStack {
                // La couleur du background
                Color("bgGreen").ignoresSafeArea()
                
                VStack {
                    
                    // SearchBar
                    SearchBar(searchText: $searchText)
                    
                    Divider()
                    
                    //Liste des projets
                    projectList
                    
                }//:VStack

            }//:ZStack
            
            .navigationBarTitle("Projets")
            .navigationBarItems(trailing: addButton)
            
            // La modale addProject
            .sheet(isPresented: $showAddProjectView, content: {
                CreateProjectView(showCreateProjectView: $showAddProjectView)
                    .environment(\.managedObjectContext, managedObjectContext)
            })
            
        } //: NAVIGATION
 
    }
}


extension ProjectListView {
    
    // Bouton Add de la NavBar
    private var addButton : some View {
        Button(action: {
            showAddProjectView = true
            
        }, label: {
            Image(systemName: "plus")
                .foregroundColor(.white)
        })
    }
    
    // Liste des projets
    private var projectList: some View {
        
        ScrollView {
            ForEach (
                projects.filter {
                    searchText.isEmpty ||
                        $0.title.localizedStandardContains(searchText)
                }
            ) { project in
                NavigationLink(
                    destination: ProjectDetailView(project: project),
                    label: {
                        ProjectRow(project: project)
                    })
                    
            }//: ForEach
        }//:ScrollView
    }
}

struct ProjectListView_Previews: PreviewProvider {
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
        
        return ProjectListView()
            .environment(\.managedObjectContext, context)

        
    }
}
