//
//  DependencyTableViewCell.swift
//  Dependencias
//
//  Created by Rigoberto Antonio Vides Rodriguez on 8/3/19.
//  Copyright © 2019 Rigoberto Antonio Vides Rodriguez. All rights reserved.
//

import UIKit

class DependencyTableViewCell: UITableViewCell {

    @IBOutlet weak var dependencyNameLabel: UILabel!
    @IBOutlet weak var dependencyAddressLabel: UILabel!
    @IBOutlet weak var mapIconImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
