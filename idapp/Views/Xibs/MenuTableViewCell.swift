//
//  MenuTableViewCell.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 04/12/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleOption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.iconView.layer.borderColor = UIColor.black.cgColor
        self.iconView.layer.borderWidth = 0.5
        self.iconView.layer.cornerRadius = (self.iconView.bounds.width / 2)
        self.iconView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
