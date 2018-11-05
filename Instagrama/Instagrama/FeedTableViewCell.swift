//
//  FeedTableViewCell.swift
//  Instagrama
//
//  Created by Raúl Torres on 11/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet var postedImage: UIImageView!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var userInfoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
