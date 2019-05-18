//
//  BaseViewController.swift
//  Buildings
//
//  Created by Liyu Wang on 10/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController, Storyboarded {

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
