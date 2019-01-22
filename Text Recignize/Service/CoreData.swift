//
//  CoreData.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/22/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//
import UIKit
import Foundation
import CoreData

class SavingData {
    
    func load() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedData")
        do {
            let results = try CoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            for result in results as! [SavedData] {
                var emptyElement = DataStructure(savedText: "", savedImage: UIImage())
                emptyElement.savedText = result.savedText!
                emptyElement.savedImage = UIImage(data: result.savedImage! as Data)!
            }
        } catch {
            print(error)
        }
    }
}
