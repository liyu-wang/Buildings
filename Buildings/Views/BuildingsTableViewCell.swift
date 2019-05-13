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
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var actionsStackView: UIStackView!
    
    var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        overlayView.backgroundColor = selected ? UIColor.black.withAlphaComponent(0.2) : UIColor.clear
        actionsStackView.isHidden = !selected
    }

}

extension BuildingsTableViewCell {
    
    func show(actions: [String]) {
        // add actions to the stack view if we never do that before
        guard actionsStackView.arrangedSubviews.count == 0 else { return }
        
        for action in actions {
            let button = ActionButton()
            button.setTitle(action, for: .normal)
            button.addTarget(self, action: #selector(BuildingsTableViewCell.buttonTapped(sender:)), for: .touchUpInside)
            
            actionsStackView.addArrangedSubview(button)
        }
    }
    
    @objc func buttonTapped(sender: Any) {
        print("haha")
    }
}
