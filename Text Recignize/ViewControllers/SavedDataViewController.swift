//
//  SavedDataViewController.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/22/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit

class SavedDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    
    @IBOutlet weak var table: UITableView!
    
    private var saveData = SaveData()
    private var tableData : [DataStructure] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setDataToVC()
        // Do any additional setup after loading the view.
//        table.rowHeight = UITableView.automaticDimension
    }
    
//    static func storyboardInstance() -> SavedDataViewController? {
//        let storyboard = UIStoryboard(name: "CoreData", bundle: nil)
//        return storyboard.instantiateInitialViewController() as? SavedDataViewController
//    }
    
    func setDataToVC() {
        
        tableData = saveData.fetchDataFromDB() 
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeTableViewCell", for: indexPath) as! PrototypeCell
        
        cell.images.image = tableData[indexPath.row].recognizedImage
        cell.value.text = tableData[indexPath.row].recignizedText
        cell.account.text = tableData[indexPath.row].account
        
        return cell
    }
    
    
    @IBAction func backToRecognize(_ sender: UIBarButtonItem) {
        
//        if let nextViewController = TextRecognizeViewController.storyboardInstance() {
//            navigationController?.pushViewController(nextViewController, animated: true)
//        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
