//
//  ProjectRow.swift
//  GreenForAllCoreDataUIKit
//
//  Created by Mounir DJIAR on 21/03/2021.
//

import SwiftUI

struct ProjectRow: View {
    
    let project:Project
    
    var body: some View {
        HStack {
            Image(project.picture)
                .resizable()
                .scaledToFill()
                .cornerRadius(8.0)
                .frame(width: 110, height:110)
                .clipped()
            
            VStack (alignment: .leading) {
                
                Text(project.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Spacer()
                
                HStack {
                    ProgressBar(value: 0.3, filColor: Color("bgGreen"))
                        .frame(height: 20)
                }//:HStack
                
                Spacer()
               
                HStack {
                    Image(systemName: "person.fill")
                    Text("10")
                        .fontWeight(.bold)
                        .padding(.leading, -10.0)
                    Spacer()
                    Image(systemName: "clock.arrow.circlepath")
                    Text("6J")
                        .fontWeight(.bold)
                        .padding(.leading, -9.0)
                    Spacer()
                    Image(systemName: "eurosign.circle")
                    Text("\(project.budget)€")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, -9.0)
                }//:HStack
                
            }//:VStack
            .padding(.vertical, 10.0)
            .padding(.horizontal, 10.0)
            .frame(idealWidth: 234, maxWidth: 235, idealHeight: 110, maxHeight: 110)
            
        }// :HSTACK
        .background(Color.white
                        .opacity(0.9))
        .cornerRadius(8.0)
        .foregroundColor(.black)

    }
}

struct ProjectRow_Previews: PreviewProvider {
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
        
        return ProjectRow(project: project1)
    }
}
