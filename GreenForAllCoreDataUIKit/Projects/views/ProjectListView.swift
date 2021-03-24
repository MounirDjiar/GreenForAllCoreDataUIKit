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
    
    @State var selectedCategory:CategoryProject = CategoryProject.energie
    
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
                    
                    Spacer()
                    Spacer()
                    
                    // Segmented Control Categories
                    CategorySegmentedControl(selectedCategory: $selectedCategory)
                    
                    Spacer()
                    Spacer()
                    
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
        .accentColor(.white)
    }
}

extension ProjectListView {
    
    // Bouton Add de la NavBar
    private var addButton : some View {
        Button(action: {
            
            // Trick to add different user
            //addUser()
            
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
                    (searchText.isEmpty || $0.title.localizedStandardContains(searchText))
                        && ($0.category == selectedCategory.rawValue)
                }
            ) { project in
                NavigationLink(
                    destination: ProjectDetailView(project: project),
                    label: {
                        ProjectRow(project: project)
                    })
                    .environment(\.managedObjectContext, managedObjectContext)
            }//: ForEach
        }//:ScrollView
    }
}

extension ProjectListView {
    func addUser() {
        // On crée une nouvelle instance Projet
        let newUser = User(context: managedObjectContext)
        
        newUser.firstname = "Batiste"
        newUser.lastname = "Mounlin"
        newUser.email = "batiste@moulin.fr"
        
        // On save la nouvelle instance dans le MOC
        do {
            print(newUser.firstname)
            try managedObjectContext.save()
        } catch {
            print(error)
        }
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
        project1.created_date = Date()
        project1.description_project = "Description du projet"
        
        // Creation du User
        let user1 = User(context: context)
        user1.firstname = "Mounir"
        user1.lastname = "DJIAR"
        user1.email = "mounir@djiar.com"
        project1.user = user1
        
        return ProjectListView()
            .environment(\.managedObjectContext, context)

    }
}
