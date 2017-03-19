//
//  ParseClient.swift
//  InstaParse
//
//  Created by Aarya BC on 2/28/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import Parse

class ParseClient {
    class func getMostRecentPosts(numberOfPosts: Int, completion: @escaping ([PFObject]) -> Void) {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "creationTime")
        query.limit = numberOfPosts
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                completion(posts)
            } else {
                print(error?.localizedDescription ?? "Unknown error")
            }
        }
    }
}
