//
//  Project+CoreDataProperties.swift
//  GreenForAllCoreDataUIKit
//
//  Created by Mounir DJIAR on 21/03/2021.
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

    @NSManaged public var title: String
    @NSManaged public var description_project: String
    @NSManaged public var picture: String
    @NSManaged public var budget: Int64
    @NSManaged public var created_date: Date
    @NSManaged public var finished_date: Date
    @NSManaged public var video: String?
    @NSManaged public var category: Int64

}

extension Project : Identifiable {

}
