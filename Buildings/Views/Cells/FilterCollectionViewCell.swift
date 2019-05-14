//
//  FilterCollectionViewCell.swift
//  Buildings
//
//  Created by Liyu Wang on 14/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagLabel: TagLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tagLabel.edgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        
    }

}
