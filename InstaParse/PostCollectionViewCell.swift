//
//  PostCollectionViewCell.swift
//  InstaParse
//
//  Created by Aarya BC on 3/19/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var creationTimeLabel: UILabel!
}
