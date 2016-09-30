//
//  Land+CoreDataProperties.swift
//  
//
//  Created by Braun Butterfield on 9/19/16.
//
//

import Foundation
import CoreData


extension Land {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Land> {
        return NSFetchRequest<Land>(entityName: "Land");
    }

    @NSManaged public var artWorkForLand: String?
    @NSManaged public var landName: String?
    @NSManaged public var question: NSSet?

}

// MARK: Generated accessors for question
extension Land {

    @objc(addQuestionObject:)
    @NSManaged public func addToQuestion(_ value: Questions)

    @objc(removeQuestionObject:)
    @NSManaged public func removeFromQuestion(_ value: Questions)

    @objc(addQuestion:)
    @NSManaged public func addToQuestion(_ values: NSSet)

    @objc(removeQuestion:)
    @NSManaged public func removeFromQuestion(_ values: NSSet)

}
