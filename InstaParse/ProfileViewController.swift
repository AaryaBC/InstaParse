//
//  ProfileViewController.swift
//  InstaParse
//
//  Created by Aarya BC on 3/20/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var dummyImage1: UIImageView!
    @IBOutlet weak var dummyImage2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imagehome = UIImage(named: "share")
        navigationItem.titleView = UIImageView(image: imagehome)
        backgroundImage.image = #imageLiteral(resourceName: "background")
        profileImage.image = #imageLiteral(resourceName: "profileimage")
        dummyImage1.image = #imageLiteral(resourceName: "cs2")
        dummyImage2.image = #imageLiteral(resourceName: "cs")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
