//
//  FeaturedView.swift
//  ScrollView
//
//  Created by Raúl Torres on 14/11/17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

class FeaturedView: UIView {
    
    @IBOutlet weak var profileImageBtn: UIButton!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var progresLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var helperView: UIView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

@IBDesignable
class ProfileImageMask : UIButton  {
    
    var maskImageView = UIImageView()
    
    @IBInspectable
    var maskImage : UIImage? {
        didSet {
            maskImageView.image = maskImage
            maskImageView.frame = self.bounds
            self.mask = maskImageView
        }
    }
}
