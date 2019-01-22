//
//  SavedData+CoraDataProperties.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/20/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import CoreData


extension SavedData {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedData> {
        return NSFetchRequest<SavedData>(entityName: "SavedData")
    }
    
    @NSManaged public var savedImage: NSData?
    @NSManaged public var savedText: String?
    
}
