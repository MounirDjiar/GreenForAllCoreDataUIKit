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
    
    let project:Project
    
    @State private var showContributionView:Bool = false
    
    var body: some View {
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
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
                    VStack (alignment: .leading){
                        Text("Avancement du projet")
                            .font(.headline)
                            .fontWeight(.bold)

                        ProgressBar(
                            value: getValue(budget: 34, contributions: 12),
                            filColor:Color("progressBarColor"),
                            bgColor: Color.white
                        )
                        .frame(height: 30)
                    }//:VStack
                    
                }//:HStack
                .padding(.vertical)
                
                HStack {
                    VStack {
                        HStack {
                            Image(systemName: "person.fill")
                                .font(.system(size: 25))
                            Text("\(project.contributions?.count ?? -1)")
                                .fontWeight(.bold)
                                .font(.system(size: 25))
                                .padding(.leading, -10.0)
                        }
                        Text("Contributeurs")
                            .font(.system(size: 14))
                    }
                    
                    Spacer()
                    VStack {
                        HStack {
                            Image(systemName: "clock.arrow.circlepath")
                                .font(.system(size: 25))
                            Text("6J")
                                .fontWeight(.bold)
                                .font(.system(size: 25))
                                .padding(.leading, -9.0)
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
                
                Spacer()
                
            }//:VStack
            .padding(.horizontal)
            .foregroundColor(.white)
            
        }//:ZStack
        .navigationBarTitle(project.title)
        
        // La modale pour la contribution
        .sheet(isPresented: $showContributionView, content: {
            ContributionView(showContributionView: $showContributionView)
                .environment(\.managedObjectContext, managedObjectContext)
        })
    }
}


extension ProjectDetailView {
    private func getValue(budget: Int, contributions: Int) ->  Float {
        return 0.4
    }
}

extension ProjectDetailView {
    private func contribute() {
        showContributionView = true
    }
}

struct ProjectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        // On récupère le contexte
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
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
        
        let user1 = User(context: context)
        
        // Le user créateur du projet
        user1.firstname = "Mounir"
        user1.lastname = "DJIAR"
    
        project1.user = user1
        
        return ProjectDetailView(project: project1)
    }
}
