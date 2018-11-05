//
//  ViewController.swift
//  DownloadingImages
//
//  Created by Raúl Torres on 03/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if !documentsPath.isEmpty {
            let documentsDirectory = documentsPath[0]
            let restorePath = documentsDirectory + "/kh3.jpg"
            //                                do {
            //                                    try UIImageJPEGRepresentation(bachImage, 1.0)?.write(to: URL(fileURLWithPath: savePath))
            //                                } catch {
            //
            //                                }
            myImageView.image = UIImage(contentsOfFile: restorePath)
        
        }
        /*
        let url = URL(string: "https://i0.wp.com/www.thebitbag.com/wp-content/uploads/2017/01/kingdom-hearts-3-release-date.jpg?w=879&ssl=1")
        
        let request = NSMutableURLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print(error)
            } else {
                if let data = data {
                    if let bachImage = UIImage(data: data) {
                        
                        DispatchQueue.main.sync {
                            self.myImageView.image = bachImage
                        }
                        
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                        if !documentsPath.isEmpty {
                            let documentsDirectory = documentsPath[0]
                            let savePath = documentsDirectory + "/kh3.jpg"
                            //                                do {
                            //                                    try UIImageJPEGRepresentation(bachImage, 1.0)?.write(to: URL(fileURLWithPath: savePath))
                            //                                } catch {
                            //
                            //                                }
                            do {
                                try bachImage.jpegData(compressionQuality: 1)?.write(to: URL(fileURLWithPath: savePath))
                            } catch {
                                
                            }
                        }
                    }
                }
            }
            
        }
        
        task.resume()
 */
    }


}

