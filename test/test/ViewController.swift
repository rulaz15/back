//
//  ViewController.swift
//  test
//
//  Created by Raúl Torres on 13/11/17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let profileImg : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "swift")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = #colorLiteral(red: 0.7816441449, green: 1, blue: 0, alpha: 1)
        image.frame.size.width = 50
        image.frame.size.height = 70
        return image
        
    }()
    
    let statusImg : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "clock")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = #colorLiteral(red: 0.003597003662, green: 0.5736933171, blue: 1, alpha: 1)
        return image
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpImages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpImages() {
        self.view.addSubview(profileImg)
        
        profileImg.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        profileImg.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileImg.widthAnchor.constraint(equalToConstant: view.bounds.width/2).isActive = true
        profileImg.heightAnchor.constraint(equalToConstant: view.bounds.height/3).isActive = true
        
        
        profileImg.addSubview(statusImg)
        
        let statusHeigth = statusImg.image?.size.height
        let profileWidth = profileImg.image?.size.width
       
        statusImg.topAnchor.constraint(equalTo: profileImg.bottomAnchor, constant: -(statusHeigth!)/2).isActive = true
        statusImg.centerXAnchor.constraint(equalTo: profileImg.centerXAnchor, constant: profileWidth!/2).isActive = true
        
        print(profileImg)
    }
    
}

