//
//  CurrentUser.swift
//  GreenForAllCoreDataUIKit
//
//  Created by Mounir DJIAR on 23/03/2021.
//

import Foundation
import SwiftUI
import CoreData

class CurrentUser: ObservableObject {
    
    @Published var user:User?
    
    var contexte: NSManagedObjectContext
    
    init(contexte: NSManagedObjectContext) {
        self.contexte = contexte
        makeRequest ()
    }
    
    func makeRequest () {
        
        let request = NSFetchRequest<User>(entityName: "User")
        request.fetchLimit = 1
        
        if let result = try? contexte.fetch(request) {
            user = (result as [User]).first
            print(user?.firstname)
        }
    }
}
