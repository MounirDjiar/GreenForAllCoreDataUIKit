//
//  CreateProjetView.swift
//  Green4all
//
//  Created by Baptiste Moulin on 18/03/2021.
//

import SwiftUI

struct CreateProjectView: View {
    
    // On récupère le Managed Object Contexte
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var showCreateProjectView:Bool
    @State var showingAlert = false
    
    @State var title: String = ""
    @State var desc: String = ""
    @State var budget: String = ""
    @State var urlvideo: String = ""
    @State var urlimg: String = ""
    @State var duree: String = ""
    
    
    @State private var selectedCategory = CategoryProject.none
    
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
        
        return NavigationView {
            ZStack {
                Color("bgGreen").ignoresSafeArea()
                
                Form {
                    TextField("Titre", text: $title)
                    Section {
                        VStack {
                            HStack {
                                Text("Catégories")
                                    .bold()
                                    .padding(.leading, -10)
                                Spacer()
                            }
                            ScrollView (.horizontal) {
                                HStack {
                                    ForEach (CategoryProject.allCases, id: \.self) { categoryProject in
                                        Button(action: {
                                            if (selectedCategory == categoryProject){
                                                selectedCategory = CategoryProject.none
                                            }
                                            else{
                                                selectedCategory = categoryProject
                                            }
                                        }, label: {
                                            if categoryProject != CategoryProject.none {
                                                if (selectedCategory == categoryProject)
                                                {
                                                    Image("\(categoryProject.categoryProjectImage)")
                                                        .resizable()
                                                        .frame(width: 125, height: 125)
                                                        .cornerRadius(5)
                                                        .border(Color.green, width: 5)
                                                }
                                                else
                                                {
                                                    Image("\(categoryProject.categoryProjectImage)")
                                                        .resizable()
                                                        .frame(width: 125, height: 125)
                                                        .cornerRadius(5)
                                                        .overlay(
                                                            VStack {
                                                                Spacer()
                                                                Text(categoryProject.categoryProjectTitle)
                                                                    .fontWeight(.heavy)
                                                                    .foregroundColor(Color.white)
                                                                Text("")
                                                                    .frame(height: 2)
                                                                
                                                            }
                                                        )
                                                }
                                            }
                                            
                                        })
                                        
                                    }
                                }
                            }.padding(.horizontal, -10)
                        }
                    }
                    
                    Section {
                        TextEditor(text: $desc)
                            .frame(height: 110.0)
                            .lineLimit(10)
                            .overlay(
                                HStack {
                                    VStack {
                                        Text("\(desc.count > 0 ? "" : "Description")")
                                            .opacity(0.25)
                                            .padding(.top, 7.0)
                                            .padding(.leading, 3.0)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            )
                    }
                    Section {
                        TextField("Budget (€)", text: $budget).keyboardType(.numberPad)
                    }
                    Section {
                        TextField("Durée de la campagne (en jours)", text: $duree).keyboardType(.numberPad)
                    }
                    
                    Section {
                        TextField("URL Image", text: $urlimg)
                    }
                    
                    Section {
                        TextField("URL Vidéo (optionnel)", text: $urlvideo)
                    }
                    
                }// :Form
                .disableAutocorrection(true)
                
            }//:ZStack
            
            .navigationBarTitle("Nouveau projet", displayMode: .inline)
            
            .navigationBarItems(
                leading: cancelButton.font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/),
                trailing: addButton.font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
            )
        }
    }
}

extension CreateProjectView {
    
    private var cancelButton: some View {
        Button("Annuler") {
            showCreateProjectView = false
        }
    }
    
    private var addButton: some View {
        Button("Créer") {
            
            if title == "" || desc == "" || Int(budget) ?? 0 == 0 || urlimg == "" || Int(duree) ?? 0 == 0 {
                showingAlert = true
            }
            else {
                // On sauvegarde les données
                save()
                
                self.showingAlert = false
                self.showCreateProjectView = false
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Attention"), message: Text("Vous devez remplir tous les champs"), dismissButton: .default(Text("OK")))
        }
    }
}

extension CreateProjectView {
    
    private func save() {
        
        // On crée une nouvelle instance Projet
        let newProject = Project(context: managedObjectContext)
        
        // On lui donne les valeurs
        newProject.title = title
        newProject.description_project = desc
        newProject.budget = Int64(budget) ?? 0
        newProject.picture = urlimg
        newProject.video = urlvideo
        newProject.created_date = Date()
        newProject.finished_date = Date().addingTimeInterval(TimeInterval(86400 * (Int(duree) ?? 0)))
        newProject.category = selectedCategory.rawValue
        
        // On save la nouvelle instance dans le MOC
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

struct CreateProjetView_Previews: PreviewProvider {
    static var previews: some View {
        
        // On récupère le contexte
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return CreateProjectView(showCreateProjectView: .constant(false))
            .environment(\.managedObjectContext, context)
    }
}


