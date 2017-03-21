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
    var dateStr: String?
    let media: PFFile?
    let username: String?
    let caption: String?
    
    init(pfObject: PFObject) {
        print(pfObject)
        
        if let postDate = pfObject.createdAt{
            let calendar = NSCalendar.current
            let components = calendar.dateComponents([.day,.hour,.minute,.second], from: postDate, to: Date())
            let day = components.day!
            let hour = components.hour!
            let minute = components.minute!
            let second = components.second!
            
            if day > 0{
                if day > 1{
                    dateStr = "\(day) days ago"
                }
                else{
                    dateStr = "1 day ago"
                }
            }
            else if hour > 0{
                if hour > 1{
                    dateStr = "\(hour) hours ago"
                }
                else{
                    dateStr = "1 hour ago"
                }
            }
            else if minute > 0{
                if minute > 1{
                    dateStr = "\(minute) minutes ago"
                }
                else{
                    dateStr = "1 minute ago"
                }
            }
            else{
                dateStr = "\(second) seconds ago"
            }
        }
        
        media = pfObject["media"] as? PFFile
        username = pfObject["username"] as? String
        caption = pfObject["caption"] as? String
    }
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Post")
        post["creationTime"] = Date.timeIntervalSinceReferenceDate
        post["media"] = getPFFileFromImage(image: image)
        post["username"] = PFUser.current()?.username
        post["caption"] = caption
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
