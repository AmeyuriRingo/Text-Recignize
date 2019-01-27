//
//  SavedData+CoreDataProperties.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/27/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import CoreData

extension RecognizedData {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecognizedData> {
        return NSFetchRequest<RecognizedData>(entityName: "RecognizedData")
    }
    
    @NSManaged public var recognizedImage: Data?
    @NSManaged public var account: String?
    @NSManaged public var recignizedText: String?
    
}
