//
//  BuildingsViewController.swift
//  Buildings
//
//  Created by Liyu Wang on 10/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class BuildingsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    private let viewModel = BuildingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configViews()
        self.setupReactive()
    }
    
}

extension BuildingsViewController {
    
    private func configViews() {
        self.tableView.rx.setDelegate(self).disposed(by: bag)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300
    }
    
    private func setupReactive() {
        self.viewModel.buildings
            .bind(to: tableView.rx.items(cellIdentifier: "BuildingsTableViewCell", cellType: BuildingsTableViewCell.self)) { (row, building, cell) in
                cell.cityLabel.text = "\(building.address.city) \(building.address.country)"
                cell.addressLabel.text = "\(building.address.line1 ?? "") \(building.address.line2 ?? "")"
                cell.buildingImageView.kf.setImage(with: URL(string: building.imageUrl))
            }.disposed(by: bag)
    }

}

// MARK: - UITableViewDelegate

extension BuildingsViewController: UITableViewDelegate {
    
}
