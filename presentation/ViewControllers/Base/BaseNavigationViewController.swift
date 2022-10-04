//
//  MainTestNavigationViewController.swift
//  presentation
//
//  Created by Nazim Asadov on 10.09.22.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
        navigationBar.isTranslucent = true
        navigationBar.barStyle = .default
        navigationBar.barTintColor = .appBackGroundColor
        navigationBar.backgroundColor = .appBackGroundColor
        navigationBar.tintColor = .label
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
    }
}
