//
//  Contribution+CoreDataProperties.swift
//  GreenForAllCoreDataUIKit
//
//  Created by Mounir DJIAR on 23/03/2021.
//
//

import Foundation
import CoreData


extension Contribution {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contribution> {
        return NSFetchRequest<Contribution>(entityName: "Contribution")
    }

    @NSManaged public var amount: Int64
    @NSManaged public var project: Project
    @NSManaged public var user: User?

}

extension Contribution : Identifiable {

}
