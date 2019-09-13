//
//  InfoCollectionCell.swift
//  Weather App
//
//  Created by Oveys Safarnejad on 9/12/19.
//  Copyright © 2019 Borna. All rights reserved.
//

import UIKit

class InfoCollectionCell: UICollectionViewCell {

    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var uv: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func generateInfoCell(info :weatherInfo) {
        
        self.info.text = info.infoText
        self.info.adjustsFontSizeToFitWidth = true
        if info.image != nil {
            
            self.uv.isHidden = true
            self.pic.isHidden = false
            self.pic.image = info.image
            
        } else {
            
            self.uv.isHidden = false
            self.pic.isHidden = true
            self.uv.adjustsFontSizeToFitWidth = true
            self.uv.text = info.uvText
            
        }

        
    }

}
