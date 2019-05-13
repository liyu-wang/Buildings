//
//  ActionButton.swift
//  Buildings
//
//  Created by Liyu Wang on 13/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

    init() {
        super.init(frame: CGRect.zero)
        
        self.contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 20.0, bottom: 8.0, right: 20.0)
        
        self.layer.cornerRadius = 6.0
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.purple.cgColor
        self.layer.masksToBounds = true
        
        self.setBackgroundImage(UIImage.image(with: UIColor.black.withAlphaComponent(0.6)), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
