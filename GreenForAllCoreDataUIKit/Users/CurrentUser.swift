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
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        getUser ()
    }
    
    func getUser () {
        
        let request = NSFetchRequest<User>(entityName: "User")
        request.fetchLimit = 1
        
        if let result = try? context.fetch(request) {
            user = (result as [User]).last
        }
    }
}
