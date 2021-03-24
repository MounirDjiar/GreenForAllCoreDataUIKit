//
//  ContentView.swift
//  GreenForAllCoreDataUIKit
//
//  Created by Mounir DJIAR on 21/03/2021.
//

import SwiftUI

struct ContentView: View {
    
    // Je récupère le current user depuis l'environement
    @EnvironmentObject var currentUser: CurrentUser
    
    var body: some View {
        // S'il a déjà compte
        if (currentUser.user != nil) {
            TabBar()
        } else {
            ProfilConnexion()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
