//
//  BuildingDetailsViewController.swift
//  Buildings
//
//  Created by Liyu Wang on 13/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class BuildingDetailsViewController: BaseViewController {

    static func newInstance(with buildingDetailsViewModel: BuildingDetailsViewModel) -> BuildingDetailsViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BuildingDetailsViewController") as! BuildingDetailsViewController
        controller.viewModel = buildingDetailsViewModel
        return controller
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var viewModel: BuildingDetailsViewModel!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configViews()
        self.setupReactive()
    }

}

// MARK: - view configs

extension BuildingDetailsViewController {
    
    private func configViews() {
        self.navigationItem.title = "Building Details"
    }
    
    private func setupReactive() {
        let buildingObservable = self.viewModel.building.share()
        
        buildingObservable
            .subscribe(
                onNext: { [weak self] building in
                    self?.imageView.kf.setImage(with: URL(string: building.imageUrl))
                }
            )
            .disposed(by: bag)
        
        buildingObservable
            .map { $0.name }
            .bind(to: self.nameLabel.rx.text)
            .disposed(by: bag)
        
        buildingObservable
            .map { "\($0.address.line1 ?? "") \($0.address.line2 ?? "") \($0.address.city) \($0.address.state ?? "") \($0.address.zipCode) \($0.address.country)" }
            .bind(to: self.addressLabel.rx.text)
            .disposed(by: bag)
    }
    
}
