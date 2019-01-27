//
//  News+CoreDataClass.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/27/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import CoreData

@objc(RecognizedData)
public class RecognizedData: NSManagedObject {
    convenience init() {
        self.init(context: CoreDataManager.instance.managedObjectContext)
    }
}
