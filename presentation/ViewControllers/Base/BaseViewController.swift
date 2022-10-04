//
//  BaseViewController.swift
//  presentation
//
//  Created by Nazim Asadov on 29.08.22.
//

import UIKit

public class BaseViewController<VM>: UIViewController {
    
    var vm: VM? = nil
    var router: RouterProtocol? = nil
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .appBackGroundColor
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.forEach { window in
                if UserDefaults.standard.bool(forKey: "Phone_Mode") {
                    window.overrideUserInterfaceStyle = .dark
                }else {
                    window.overrideUserInterfaceStyle = .light
                }
            }
        }else {
            view.backgroundColor = .appBackGroundColor
        }
    }
}

