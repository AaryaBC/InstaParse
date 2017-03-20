//
//  HomeViewController.swift
//  InstaParse
//
//  Created by Aarya BC on 3/18/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import ParseUI

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var posts = [Post]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.reloadData()
        let image = UIImage(named: "share")
        navigationItem.titleView = UIImageView(image: image)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPosts()
    }
    
    private func loadPosts() {
        ParseClient.getMostRecentPosts(numberOfPosts: 20) { pfObjects in
            self.posts = pfObjects.map { pfObject in return Post(pfObject: pfObject) }
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (self.posts.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
            let post = posts[indexPath.row]
            
        cell.postImageView.file = post.media
        cell.postImageView.loadInBackground()
        cell.usernameLabel.text = post.username
        let firstChar = post.username?[(post.username?.startIndex)!]
        cell.buttonPic.setTitle("\(firstChar!)", for: .normal)
        cell.buttonPic.layer.cornerRadius = 0.5 * cell.buttonPic.bounds.size.width
        cell.buttonPic.layer.borderWidth = 2.0
        cell.buttonPic.frame.size = CGSize(width: 25, height: 25)
        cell.buttonPic.clipsToBounds = true
        cell.creationTimeLabel.text = post.dateStr
        cell.captionLABEL.text = post.caption
        cell.commentLabel.text = post.username
        return cell
    }
    
    @IBAction func onLogoutPressed(_ sender: Any) {
        PFUser.logOut()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogOut"), object: nil)
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
