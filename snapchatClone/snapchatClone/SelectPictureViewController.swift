//
//  SelectPictureViewController.swift
//  snapchatClone
//
//  Created by Raúl Torres on 14/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import Firebase

class SelectPictureViewController: UIViewController {

    let imagePicker = UIImagePickerController()
    let imageName = "\(NSUUID().uuidString).jpg"
    
    var imageAdded = false
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var messgeTF: UITextField!
    
    @IBAction func selectPhotoAction(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        if imageAdded && !(messgeTF.text?.isEmpty)! {
            //uploadImage
            let imagesFolder = Storage.storage().reference().child("images")
            if let imageData = imageView.image?.jpegData(compressionQuality: 0.1) {
               
                imagesFolder.child(imageName).putData(imageData, metadata: nil) { (metadata, error) in
                    if error != nil {
                        self.showAlert(msg: (error?.localizedDescription)!)
                    } else {
                        //segue to next VC

                        Storage.storage().reference().child("images/\(self.imageName)").downloadURL(completion: { (url, error) in
                            if error != nil {
                                self.showAlert(msg: error!.localizedDescription)
                            } else {
                                
                                self.performSegue(withIdentifier: "selectReceiverSegue", sender: url?.absoluteString)
                            }
                        })
                        
//                        self.performSegue(withIdentifier: "selectReceiverSegue", sender: self)
                    }
                }
            }
        } else {
            //missing something
           showAlert(msg: "provide image and message")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showAlert(msg: String) {
        let alertC = UIAlertController(title: "error", message: msg, preferredStyle: .alert)
        let alertA = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertC.addAction(alertA)
        self.present(alertC, animated: true, completion: nil)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let downloadURL = sender as? String {
            if let destVC = segue.destination as? SelectRecipientTableViewController {
                destVC.downloadURL = downloadURL
                destVC.message = messgeTF.text!
                destVC.imageName = imageName
            }
        }
    }


}

extension SelectPictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            imageAdded = true
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
