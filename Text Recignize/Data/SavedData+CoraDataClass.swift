//
//  SavedData+CoraDataClass.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/20/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import CoreData

@objc(SavedData)
public class SavedData: NSManagedObject {
    convenience init() {
        self.init(context: CoreDataManager.instance.managedObjectContext)
    }
}

