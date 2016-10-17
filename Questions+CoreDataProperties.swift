//
//  Questions+CoreDataProperties.swift
//  
//
//  Created by Braun Butterfield on 10/16/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Questions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questions> {
        return NSFetchRequest<Questions>(entityName: "Questions");
    }

    @NSManaged public var answerBool: Bool
    @NSManaged public var correctAnswer: String?
    @NSManaged public var keyboardType: Bool
    @NSManaged public var questionInt: NSNumber?
    @NSManaged public var questionTitle: String?
    @NSManaged public var resultImage: NSData?
    @NSManaged public var theQuestion: String?
    @NSManaged public var land: Land?

}
