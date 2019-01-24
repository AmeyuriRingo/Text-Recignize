//
//  TableViewController.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/22/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    private var tableData : [DataStructure] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static func storyboardInstance() -> TableViewController? {
        let storyboard = UIStoryboard(name: "CoreData", bundle: nil)
        return storyboard.instantiateInitialViewController() as? TableViewController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeTableViewCell", for: indexPath) as! PrototypeCell
        
        cell.images.image = tableData[indexPath.row].savedImage
        cell.value.text = tableData[indexPath.row].savedText
                
        return cell
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
