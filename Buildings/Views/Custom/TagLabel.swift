//
//  TagLabel.swift
//  Buildings
//
//  Created by Liyu Wang on 14/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import UIKit

class TagLabel: UILabel {
    var edgeInsets: UIEdgeInsets
    
    override init(frame: CGRect) {
        self.edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        super.init(frame: frame)
        
        self.configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        super.init(coder: aDecoder)
        
        self.configView()
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.edgeInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += (self.edgeInsets.left + self.edgeInsets.right)
        size.height += (self.edgeInsets.top + self.edgeInsets.bottom)
        return size
    }
}

extension TagLabel {
    
    private func configView() {
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 16)
        self.textColor = UIColor.darkGray
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
}
