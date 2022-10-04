//
//  BaseTabbarController.swift
//  presentation
//
//  Created by Nazim Asadov on 15.09.22.
//

import Foundation
import UIKit

public class BaseTabController<VM>: UITabBarController {
    var vm: VM
    var router:RouterProtocol
    
    init(
        vm: VM,
        router: RouterProtocol
    ) {
        self.vm = vm
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
