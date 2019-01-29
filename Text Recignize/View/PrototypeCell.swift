//
//  SavedDataTableCell.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/20/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit

class PrototypeCell : UITableViewCell {

    @IBOutlet weak var value: UITextView!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var account: UILabel!
    
    override func prepareForReuse() {
        
        images.image = nil
        value.text = nil
        account.text = nil
    }
}
