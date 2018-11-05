//
//  MainPageViewController.swift
//  VideoCamera
//
//  Created by Raúl Torres on 17/11/17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit
import AVKit

class MainPageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let imagePickerController = UIImagePickerController()
    var videoURL: URL?
    
    @IBAction func openGalleryAction(_ sender: UIButton) {
        
        if sender.tag == 1 {
            imagePickerController.sourceType = .photoLibrary
            
        } else if sender.tag == 2 {
            imagePickerController.sourceType = .camera
        }
        
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image"]
        imagePickerController.allowsEditing = true
        //imagePickerController.videoMaximumDuration = 30
        
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        videoURL = info[UIImagePickerControllerMediaURL] as? URL
        //videoURL = info["UIImagePickerControllerReferenceURL"] as? URL
        print("videoooo \(videoURL as Any)")
        //print("descripcion:\n\(String(describing: info[UIImagePickerControllerMediaURL]))\n)")
        let asset = AVAsset(url: videoURL!)
        let duration = asset.duration
        let durationTime = CMTimeGetSeconds(duration)
        
        print("""
            durationTimee: \(durationTime)
            duration: \(duration)
            """)
        imagePickerController.dismiss(animated: true, completion: nil)
//
//        if let videoURL = videoURL{
//            let player = AVPlayer(url: videoURL)
//
//            let playerViewController = AVPlayerViewController()
//            playerViewController.player = player
//
//            present(playerViewController, animated: true) {
//                playerViewController.player!.play()
//            }
//        }
        
        
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
