//
//  PlayerViewController.swift
//  VideoCamera
//
//  Created by Raúl Torres on 16/11/17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController, UIVideoEditorControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        player?.pause()
        //showsPlaybackControls = false

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
