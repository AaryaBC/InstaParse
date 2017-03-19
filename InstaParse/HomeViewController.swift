//
//  HomeViewController.swift
//  InstaParse
//
//  Created by Aarya BC on 3/18/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import ParseUI

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.collectionViewLayout = {
            let spacing: CGFloat = 8.0
            let numberOfCellPerRow: CGFloat = 2
            
            let width: CGFloat = collectionView.frame.width - spacing * 2
            
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            layout.itemSize = CGSize(
                width: width / numberOfCellPerRow - (numberOfCellPerRow - 1) * spacing,
                height: width / numberOfCellPerRow - (numberOfCellPerRow - 1) * spacing)
            return layout
        }()
        
        loadPosts()
    }
    
    private func loadPosts() {
        ParseClient.getMostRecentPosts(numberOfPosts: 20) { pfObjects in
            self.posts = pfObjects.map { pfObject in return Post(pfObject: pfObject) }
            self.collectionView.reloadData()
        }
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

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as? PostCollectionViewCell {
            let post = posts[indexPath.row]
            cell.postImageView.file = post.media
            cell.postImageView.loadInBackground()
            cell.usernameLabel.text = post.username
            
            if let creationTime = post.creationTime {
                let postDateFormatter: DateFormatter = {
                    let f = DateFormatter()
                    f.dateFormat = "MM/dd/yyyy @ hh:mm:ss"
                    return f
                }()
                cell.creationTimeLabel.text = postDateFormatter.string(from: Date(timeIntervalSinceReferenceDate: creationTime))
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
}
