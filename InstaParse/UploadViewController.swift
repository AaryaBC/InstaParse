//
//  UploadViewController.swift
//  InstaParse
//
//  Created by Aarya BC on 3/19/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var postPhotoLabel: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var pickImageButton: UIButton!
    @IBOutlet weak var uploadButton: UIButton!
    let picker = UIImagePickerController()
    var image = [PFFile]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "share")
        navigationItem.titleView = UIImageView(image: image)
        // Do any additional setup after loading the view.
    }

    @IBAction func pickImageButtonClicked(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        postPhotoLabel.image = editedImage
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Post.postUserImage(image: postPhotoLabel.image,
                           withCaption: captionTextField.text,
                           withCompletion: { _ in
                            DispatchQueue.main.async {
                                self.postPhotoLabel.image = nil
                                self.captionTextField.text = nil
                                MBProgressHUD.hide(for: self.view, animated: true)
                            }}
        )
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
