//
//  BuildingsTableViewCell.swift
//  Buildings
//
//  Created by Liyu Wang on 12/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import UIKit

class BuildingsTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tickView: UIImageView!
    @IBOutlet weak var buildingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
