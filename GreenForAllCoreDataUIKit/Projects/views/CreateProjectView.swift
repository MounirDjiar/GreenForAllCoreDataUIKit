//
//  CreateProjetView.swift
//  Green4all
//
//  Created by Baptiste Moulin on 18/03/2021.
//

import UIKit
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

struct CreateProjectView: View {
    
    // On récupère le Managed Object Contexte
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // Je récupère le current user depuis l'environement
    @EnvironmentObject var currentUser: CurrentUser
    
    @Binding var showCreateProjectView:Bool
    @State var showingAlert = false
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    @State var title: String = ""
    @State var desc: String = ""
    @State var budget: String = ""
    @State var urlvideo: String = ""
    @State var urlimg: URL? = URL(string: "google.com")
    @State var duree: String = ""
    
    
    @State private var selectedCategory = CategoryProject.energie
    
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
                                                //selectedCategory = CategoryProject.none
                                            }
                                            else{
                                                selectedCategory = categoryProject
                                            }
                                        }, label: {
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
                        HStack {
                            Button (action: {
                                self.showingImagePicker = true
                                if let timage = inputImage {
                                    if let tdata = timage.pngData() {
                                        urlimg = getDocumentsDirectory().appendingPathComponent("CP-" + title + ".png")
                                        try? tdata.write(to: urlimg!)
                                    }
                                }
                            }, label: {
                                HStack {
                                    Text("Selectionnez une image")
                                    Spacer()
                                    (image ?? Image(systemName: "person"))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                }
                            })
                        }
                    }
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: self.$inputImage)
                    }
                    
                    //                    Section {
                    //                        TextField("URL Vidéo (optionnel)", text: $urlvideo)
                    //                    }
                    
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
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
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
            
            if title == "" || desc == "" || Int(budget) ?? 0 == 0 || urlimg == nil || Int(duree) ?? 0 == 0 {
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
        newProject.picture = "\(urlimg)"
        newProject.video = urlvideo
        newProject.created_date = Date()
        newProject.finished_date = Date().addingTimeInterval(TimeInterval(86400 * (Int(duree) ?? 0)))
        newProject.category = selectedCategory.rawValue
        newProject.user = currentUser.user
        
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
        
        // Instanciation CurrentUser
        let currentUser = CurrentUser(context: context)
        
        return CreateProjectView(showCreateProjectView: .constant(false))
            .environment(\.managedObjectContext, context)
            .environmentObject(currentUser)
    }
}



