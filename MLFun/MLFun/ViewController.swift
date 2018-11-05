//
//  ViewController.swift
//  MLFun
//
//  Created by Raúl Torres on 08/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UINavigationControllerDelegate {

    let resnetModel = Resnet50()
    let imagePicker = UIImagePickerController()
    
    @IBOutlet var objectImageView: UIImageView!
    @IBOutlet var objectLabel: UILabel!
    @IBOutlet var confidentLabel: UILabel!
    
    @IBAction func libraryBarBtnAction(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraBarBtnAction(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
        processImage()
        
 
    }
    
    func processImage() {
        if let model = try? VNCoreMLModel(for: self.resnetModel.model) {
            let request = VNCoreMLRequest(model: model) { (request, error) in
                if let results = request.results as? [VNClassificationObservation] {
                    print("/////////////////////////////////////////////////////\n")
                    for clasification in results {
                        print("ID: \(clasification.identifier) Confidence: \(clasification.confidence)")
                        
                    }
                    
                    if let result = results.first {
                        self.objectLabel.text = result.identifier
                        self.confidentLabel.text = "\(result.confidence*100)%"
                    }
                }
            }
            
            if let image = objectImageView.image {
            if let imgData = image.pngData() {
                let handler = VNImageRequestHandler(data: imgData, options: [:])
                
                try? handler.perform([request])
            }
            }
        }
    }
}

extension ViewController : UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage {
            objectImageView.image = img
            
            processImage()
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
