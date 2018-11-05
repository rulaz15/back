//
//  PostViewController.swift
//  Bolts
//
//  Created by Raúl Torres on 10/07/18.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate {

    let actIndicator = UIActivityIndicatorView()
    
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var commentTF: UITextField!
    
    @IBAction func chooseImageBtnAction(_ sender: Any) {
        
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.allowsEditing = true
        imageController.sourceType = .photoLibrary
        
        self.present(imageController, animated: true, completion: nil)
        
    }
    
    @IBAction func postBtnAction(_ sender: Any) {
        
        if let image = postImageView.image {
            let post = PFObject(className: "Post")
            post["message"] = commentTF.text
            post["userID"] = PFUser.current()?.objectId
            
            if let imageData = image.pngData(){
                
                showActIndicator(show: true)
                
                let imageFile = PFFile(name: "image.png", data: imageData)
                post["imageFile"] = imageFile
                post.saveInBackground { (success, error) in
                    
                    self.showActIndicator(show: false)
                    
                    if success {
                        showAlert(title: "Image posted", message: "success :D", handler: nil, vc: self)
                        
                        self.postImageView.image = nil
                        self.commentTF.text = ""
                    } else {
                        if let error = error {
                            showAlert(title: "Post failed", message: error.localizedDescription, handler: nil, vc: self)
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        actIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        actIndicator.center = self.view.center
        actIndicator.hidesWhenStopped = true
        actIndicator.style = .gray
        view.addSubview(actIndicator)
    }
    
    func showActIndicator(show: Bool) {
        if show {
            actIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        } else {
            actIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PostViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            postImageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
