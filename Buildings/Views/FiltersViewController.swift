//
//  FiltersViewController.swift
//  Buildings
//
//  Created by Liyu Wang on 10/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FiltersViewController: BaseViewController {

    var viewModel: FiltersViewModel = FiltersViewModel()
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @objc func clearButtonTapped(sender: UIButton) {
        if sender.tag == 0 {
            self.viewModel.clearSelectedCountries()
        } else {
            self.viewModel.clearSelectedCities()
        }
        self.filterCollectionView.reloadData()
    }
}

extension FiltersViewController: UICollectionViewDataSource  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? self.viewModel.numberOfCountries() : self.viewModel.numberOfCities()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        
        let str = self.viewModel.countryOrCityStr(at: indexPath)
        cell.tagLabel.text = str
        cell.tagLabel.backgroundColor = self.viewModel.isTagSelected(at: indexPath) ? UIColor.green : UIColor.clear
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: "FillterCollectionViewSupplementaryHeader",
                                                                             for: indexPath) as! FilterCollectionViewSupplimentaryHeader
            headerView.filterLabel.text = indexPath.section == 0 ? "Country" : "City"
           
            headerView.clearButton.tag = indexPath.section
            headerView.clearButton.removeTarget(self, action: #selector(FiltersViewController.clearButtonTapped(sender:)), for: .touchUpInside)
            headerView.clearButton.addTarget(self, action: #selector(FiltersViewController.clearButtonTapped(sender:)), for: .touchUpInside)
            
            return headerView
        }
        return UICollectionReusableView()
    }
    
}

extension FiltersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let str = self.viewModel.countryOrCityStr(at: indexPath)
        let rect = NSString(string: str).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                                               options: [],
                                                               attributes: [.font: UIFont.systemFont(ofSize: 16)],
                                                               context: nil)
        // refer to the UIEdgeInset of the BATagLabel in FilterCollectionViewCell
        let size = rect.insetBy(dx: 2 * -4, dy: 2 * -2).size
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let str = self.viewModel.countryOrCityStr(at: indexPath)
        if indexPath.section == 0 {
            self.viewModel.update(country: str)
        } else {
            self.viewModel.update(city: str)
        }
        collectionView.reloadData()
    }
    
}
