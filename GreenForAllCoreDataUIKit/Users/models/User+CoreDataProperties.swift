//
//  User+CoreDataProperties.swift
//  GreenForAllCoreDataUIKit
//
//  Created by Mounir DJIAR on 23/03/2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        let request = NSFetchRequest<User>(entityName: "User")
        request.sortDescriptors = [NSSortDescriptor(key: "firstname", ascending: false)]
        return request
    }
    
    @NSManaged public var email: String
    @NSManaged public var firstname: String
    @NSManaged public var lastname: String
    @NSManaged public var contributions: NSSet?
    @NSManaged public var projects: NSSet?

}

// MARK: Generated accessors for contributions
extension User {

    @objc(addContributionsObject:)
    @NSManaged public func addToContributions(_ value: Contribution)

    @objc(removeContributionsObject:)
    @NSManaged public func removeFromContributions(_ value: Contribution)

    @objc(addContributions:)
    @NSManaged public func addToContributions(_ values: NSSet)

    @objc(removeContributions:)
    @NSManaged public func removeFromContributions(_ values: NSSet)

}

// MARK: Generated accessors for projects
extension User {

    @objc(addProjectsObject:)
    @NSManaged public func addToProjects(_ value: Project)

    @objc(removeProjectsObject:)
    @NSManaged public func removeFromProjects(_ value: Project)

    @objc(addProjects:)
    @NSManaged public func addToProjects(_ values: NSSet)

    @objc(removeProjects:)
    @NSManaged public func removeFromProjects(_ values: NSSet)

}

extension User : Identifiable {

}
