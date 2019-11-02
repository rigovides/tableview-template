//
//  CustomCell.swift
//  Dependencias
//
//  Created by usuario on 11/2/19.
//  Copyright © 2019 Rigoberto Antonio Vides Rodriguez. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
