//
//  Post.swift
//  InstaParse
//
//  Created by Aarya BC on 3/18/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    let creationTime: TimeInterval?
    let media: PFFile?
    let username: String?
    let caption: String?
    let likesCount: Int?
    let commentsCount: Int?
    
    init(pfObject: PFObject) {
        print(pfObject)
        
        creationTime = pfObject["creationTime"] as? TimeInterval
        media = pfObject["media"] as? PFFile
        username = pfObject["username"] as? String
        caption = pfObject["caption"] as? String
        likesCount = pfObject["likesCount"] as? Int
        commentsCount = pfObject["commentsCount"] as? Int
    }
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Post")
        post["creationTime"] = Date.timeIntervalSinceReferenceDate
        post["media"] = getPFFileFromImage(image: image)
        post["username"] = PFUser.current()?.username
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        post.saveInBackground(block: completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let resizedImage = resize(image: image, newScale: 0.5) {
                if let imageData = UIImagePNGRepresentation(resizedImage) {
                    return PFFile(name: "image.png", data: imageData)
                }
            }
        }
        return nil
    }
    
    private class func resize(image: UIImage, newScale: CGFloat) -> UIImage? {
        let size = image.size
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width * newScale, height: size.height * newScale))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
