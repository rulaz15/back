//
//  UpdateViewController.swift
//  TinderClone
//
//  Created by Raúl Torres on 11/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import Parse

class UpdateViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userGenderSwitch: UISwitch!
//    @IBOutlet var interestedGenderSwitch: NSLayoutConstraint!
    
    @IBOutlet var interestedGenderSwitch: UISwitch!
    
    @IBAction func updateProfileBtnAction(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func updateBtnAction(_ sender: Any) {
        PFUser.current()?["isFemale"] = userGenderSwitch.isOn
        PFUser.current()?["isInterestedInWomen"] = interestedGenderSwitch.isOn
        
        if let image = profileImageView.image {
            if let imageData = image.pngData() {
                PFUser.current()?["photo"] = PFFile(name: "profile.png", data: imageData)
                
                PFUser.current()?.saveInBackground(block: { (success, error) in
                    if error != nil {
                        showAlert(title: "Whoops", message: error?.localizedDescription ?? "Try again", handler: nil, vc: self)
                        
                    } else {
//                        showAlert(title: "hurray", message: "success :D", handler: nil, vc: self)
                        self.performSegue(withIdentifier: "updateToSwipeSegue", sender: nil)
                    }
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        createWomen()
        
        if let isFemale = PFUser.current()?["isFemale"] as? Bool {
            userGenderSwitch.setOn(isFemale, animated: false)
        }
        
        if let isInterested = PFUser.current()?["isInterestedInWomen"] as? Bool {
            interestedGenderSwitch.setOn(isInterested, animated: false)
        }
        
        if let photo = PFUser.current()?["photo"] as? PFFile {
            photo.getDataInBackground { (data, error) in
                if let imageData = data {
                    if let image = UIImage(data: imageData) {
                        self.profileImageView.image = image
                    }
                }
            }
        }
    }
    
    func createWomen(){
        let imgUrls = [
        "https://i.pinimg.com/originals/fe/9d/73/fe9d73f3d18fec6570edc6f2dffc4888.jpg",
        "https://vignette.wikia.nocookie.net/atfanfic/images/3/3e/FlamePrincess.png/revision/latest?cb=20121101170731",
        "https://vignette.wikia.nocookie.net/adventuretimewithfinnandjake/images/7/79/Cake_001.png/revision/latest?cb=20121023165252",
        "https://vignette.wikia.nocookie.net/adventuretimewithfinnandjake/images/4/41/FlowerGirlPenguin.png/revision/latest?cb=20120116052956",
        "https://vignette.wikia.nocookie.net/adventuretimewithfinnandjake/images/b/b9/S3e9_Ice_Queen.png/revision/latest?cb=20110726220831",
        "https://i.pinimg.com/originals/7f/36/2d/7f362dac57890712b2c68826e4529ef1.jpg",
        "https://img00.deviantart.net/0ecd/i/2011/147/7/c/adventure_time__susan_strong_by_generalisimojenny-d3hcos8.png",
        "https://pm1.narvii.com/6574/e7eb9ce3c9722043183ba189d69139e84fd1738b_hq.jpg",
        "https://vignette.wikia.nocookie.net/adventuretimewithfinnandjake/images/c/cb/13bubblegum.png/revision/latest?cb=20110504011232",
        "https://i.pinimg.com/originals/62/b8/cc/62b8cc73058fdee8a4994d9363d3fca5.jpg",
        "https://i.ytimg.com/vi/XMw3YzUp-qo/maxresdefault.jpg",
        "https://i.pinimg.com/originals/52/14/73/521473ca74708cfbba00823185965b63.png",
        "http://img2.wikia.nocookie.net/__cb20120531205431/horadeaventura/es/images/4/4f/Princess_Monster_Wife_transparent.png",
        "https://i.ytimg.com/vi/l6OtqmCGJwY/maxresdefault.jpg",
        "http://www.cellshop.com/v2/473453-large_default/boneco-bmo---adventure-time---television-funko-pop--52.jpg"
        ]
        
        var counter = 0
        
        for imgUrl in imgUrls {
            counter += 1
            if let url = URL(string: imgUrl) {
                
                do {
                    let data = try Data(contentsOf: url)
                    let imageFile = PFFile(name: "img.png", data: data)
                    
                    let user = PFUser()
                    user["photo"] = imageFile
                    user.username = String(counter)
                    user.password = "hola"
                    user["isFemale"] = true
                    user["isInterestedInWomen"] = false
                    
                    user.signUpInBackground { (success, error) in
                        if success {
                            print("women user created!")
                        }
                    }
                    
                } catch {
//                    print("image data error")
                }
            }
            
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

extension UpdateViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
