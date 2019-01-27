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
import Firebase

class SaveData {
    
    func fetchDataFromDB() -> [DataStructure] {
        
        var fetchedTableData: [DataStructure] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecognizedData")
        do {
            let results = try CoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            for result in results as! [RecognizedData] {
                var emptyElement = DataStructure(recignizedText: "", recognizedImage: UIImage(), account: "")
                emptyElement.recignizedText = result.recignizedText!
                emptyElement.account = result.account!
                emptyElement.recognizedImage = UIImage(data: result.recognizedImage ?? NSData() as Data) ?? UIImage()
                fetchedTableData.append(emptyElement)
            }
        } catch {
            print(error)
        }
        return fetchedTableData
    }
    
    func localStorageSave(text: String, image: UIImage) {
        
        var managedObject : [RecognizedData] = []
        let emptyElement = RecognizedData()
        
        emptyElement.recognizedImage = image.pngData()
        emptyElement.recignizedText = text
        //emptyElement.account = Auth.auth().currentUser?.email
        FIR
        managedObject.append(emptyElement)
        CoreDataManager.instance.saveContext()
        
    }
}
