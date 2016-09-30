//
//  Questions+CoreDataProperties.swift
//  
//
//  Created by Braun Butterfield on 9/19/16.
//
//

import Foundation
import CoreData


extension Questions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questions> {
        return NSFetchRequest<Questions>(entityName: "Questions");
    }

    @NSManaged public var correctAnswer: String?
    @NSManaged public var keyboardType: String?
    @NSManaged public var questionInt: NSNumber?
    @NSManaged public var questionTitle: String?
    @NSManaged public var resultImage: NSData?
    @NSManaged public var theQuestion: String?
    @NSManaged public var land: Land?

}
