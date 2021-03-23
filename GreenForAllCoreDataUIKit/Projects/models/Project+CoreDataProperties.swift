//
//  Project+CoreDataProperties.swift
//  GreenForAllCoreDataUIKit
//
//  Created by Mounir DJIAR on 23/03/2021.
//
//

import Foundation
import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        let request = NSFetchRequest<Project>(entityName: "Project")
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: false)]
        return request
    }

    @NSManaged public var budget: Int64
    @NSManaged public var category: Int64
    @NSManaged public var created_date: Date?
    @NSManaged public var description_project: String
    @NSManaged public var finished_date: Date?
    @NSManaged public var picture: String
    @NSManaged public var title: String
    @NSManaged public var video: String?
    @NSManaged public var contributions: NSSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for contributions
extension Project {

    @objc(addContributionsObject:)
    @NSManaged public func addToContributions(_ value: Contribution)

    @objc(removeContributionsObject:)
    @NSManaged public func removeFromContributions(_ value: Contribution)

    @objc(addContributions:)
    @NSManaged public func addToContributions(_ values: NSSet)

    @objc(removeContributions:)
    @NSManaged public func removeFromContributions(_ values: NSSet)

}

extension Project : Identifiable {

}
