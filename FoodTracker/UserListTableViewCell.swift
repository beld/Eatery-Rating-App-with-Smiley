//
//  UserListTableViewCell.swift
//  Eatery Star
//
//  Created by Ding on 5/17/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    // MARK: Properties
    
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userGender: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
