
 //
//  PreviewViewController.swift
//  CustomCamera
//
//  Created by Raúl Torres on 16/11/17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    var image: UIImage!
    
    @IBOutlet weak var photoView: UIImageView!
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    //UIImageWriteToSavedPhotosAlbum(image, nil, #selector(saveEnded), nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        photoView.image = self.image
        UIImageWriteToSavedPhotosAlbum(image, nil,nil, nil)
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
