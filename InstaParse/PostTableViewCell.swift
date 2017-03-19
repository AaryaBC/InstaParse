//
//  PostTableViewCell.swift
//  InstaParse
//
//  Created by Aarya BC on 3/19/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var creationTimeLabel: UILabel!
    @IBOutlet weak var captionLABEL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
