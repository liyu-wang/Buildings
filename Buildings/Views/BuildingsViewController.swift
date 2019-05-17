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
import CoreLocation
import MapKit

fileprivate let buildingsTableViewCell = "BuildingsTableViewCell"
fileprivate let estimatedRowHeight: CGFloat = 300

class BuildingsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingSpinner: UIView!
    
    private let viewModel = BuildingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configViews()
        self.setupReactive()
        
        self.viewModel.fetchBuildings()
    }

}

// MARK: - view configs

extension BuildingsViewController {
    
    private func configViews() {
        self.navigationItem.title = "Building List"
        
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = estimatedRowHeight
    }
    
    private func setupReactive() {
        self.viewModel.buildings
            .bind(to: tableView.rx.items(cellIdentifier: buildingsTableViewCell, cellType: BuildingsTableViewCell.self)) { (row, building, cell) in
                cell.cityLabel.text = "\(building.address.city) \(building.address.country)"
                cell.addressLabel.text = "\(building.address.line1 ?? "") \(building.address.line2 ?? "")"
                cell.buildingImageView.kf.setImage(with: URL(string: building.imageUrl))
                cell.tickView.isHidden = !building.registered
            }
            .disposed(by: bag)
        
        self.viewModel.isLoading
            .observeOn(MainScheduler.instance)
            .skip(1)
            .map { !$0 }
            .bind(to: self.loadingSpinner.rx.isHidden)
            .disposed(by: bag)
    }
    
}

// MARK: - Actions

extension BuildingsViewController {
    
    func didPerform(action: ProductAction, on cell: BuildingsTableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        let building = self.viewModel.building(at: indexPath.row)
        
        switch action {
        case .assetMap:
            self.openMap(for: building)
        case .assetExplorer:
            self.pushDetailsViewController(for: building)
        case .assetRegister:
            self.resgister(building)
        }
    }
    
    private func openMap(for building: Building) {
        let coordinate = CLLocationCoordinate2D(latitude: building.address.latitude, longitude: building.address.longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = building.name
        mapItem.openInMaps(launchOptions: [:])
    }
    
    private func pushDetailsViewController(for building: Building) {
        let buildingDetailsVC = BuildingDetailsViewController.newInstance(with: BuildingDetailsViewModel(with: building))
        self.navigationController?.pushViewController(buildingDetailsVC, animated: true)
    }
    
    private func resgister(_ building: Building) {
        building.registered = true
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension BuildingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BuildingsTableViewCell else { return }
        
        let building = self.viewModel.building(at: indexPath.row)
        cell.configStackView(with: building.availableProducts)
        cell.controller = self
    }
    
}
