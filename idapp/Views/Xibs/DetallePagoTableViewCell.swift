//
//  DetallePagoTableViewCell.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 18/08/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import UIKit

class DetallePagoTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var tittle: UILabel!
    @IBOutlet weak var detalleOne: UILabel!
    @IBOutlet weak var detalleTwo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
