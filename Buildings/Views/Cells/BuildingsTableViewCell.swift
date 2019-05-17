//
//  BuildingsTableViewCell.swift
//  Buildings
//
//  Created by Liyu Wang on 12/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import UIKit

fileprivate let assetMapBtnTag = 100
fileprivate let assetExplorerBtnTag = 101
fileprivate let assetRegisterBtnTag = 102

class BuildingsTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tickView: UIImageView!
    @IBOutlet weak var buildingImageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var actionsStackView: UIStackView!
    
    // weak ref to the owning controller, so later we can forward actions to the owning controller
    weak var controller: BuildingsViewController?
    
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
    
    func configStackView(with actions: [ProductAction]) {
        // clear existing actions button, reused cell might have previous generated buttons
        let arrangedSubviews = actionsStackView.arrangedSubviews
        for v in arrangedSubviews {
            v.removeFromSuperview()
        }
        
        // generating new action buttons
        for action in actions {
            let button = ActionButton()
            button.setTitle(action.title, for: .normal)
            button.addTarget(self, action: #selector(BuildingsTableViewCell.buttonTapped(sender:)), for: .touchUpInside)
            switch action {
            case .assetMap:
                button.tag = assetMapBtnTag
            case .assetExplorer:
                button.tag = assetExplorerBtnTag
            case .assetRegister:
                button.tag = assetRegisterBtnTag
            }
            
            actionsStackView.addArrangedSubview(button)
        }
    }
    
    @objc func buttonTapped(sender: Any) {
        if let button = sender as? UIButton {
            var action = ProductAction.assetMap
            if button.tag == assetExplorerBtnTag {
                action = .assetExplorer
            } else if button.tag == assetRegisterBtnTag  {
                action = .assetRegister
            }
            self.controller?.didPerform(action: action, on: self)
        }
    }
}
