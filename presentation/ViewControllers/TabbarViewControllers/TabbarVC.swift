//
//  TabbarViewControllers.swift
//  presentation
//
//  Created by Nazim Asadov on 10.09.22.
//

import Foundation
import UIKit

public class TabbarViewControllers: BaseTabController<FirstViewModel> {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = router.homeViewController()
        homeVC.delegate = self
        let searchVC = router.searchViewController()
        let favoritesVC = router.favoritesViewController()
        let profileVC = router.profileViewController()

        let homeNav = BaseNavigationViewController(rootViewController: homeVC)
        let searchNav = BaseNavigationViewController(rootViewController: searchVC)
        let favoritesNav = BaseNavigationViewController(rootViewController: favoritesVC)
        let profileNav = BaseNavigationViewController(rootViewController: profileVC)

        if #available(iOS 15.0, *) {
            homeNav.navigationBar.prefersLargeTitles = false
            homeNav.tabBarItem = UITabBarItem(title: "Home",
                                              image: Asset.icHome.image.preparingThumbnail(of: CGSize(width: 24, height: 24)),
                                              selectedImage: Asset.icHomeSelected.image.withTintColor(.systemOrange).preparingThumbnail(of: CGSize(width: 24, height: 24)))
            
            searchNav.tabBarItem = UITabBarItem(title: "Search",
                                                image: Asset.searchFirst.image.preparingThumbnail(of: CGSize(width: 26, height: 26)),
                                                selectedImage: Asset.searchSelected.image.preparingThumbnail(of: CGSize(width: 25, height: 25)))
            
            favoritesNav.tabBarItem = UITabBarItem(title: "Favorites",
                                                   image: Asset.starOutlined.image.preparingThumbnail(of: CGSize(width: 24, height: 24)),
                                                   selectedImage: Asset.starOutlinedFilled.image.preparingThumbnail(of: CGSize(width: 26, height: 26)))

            profileNav.navigationItem.title = "Profile"
            profileNav.tabBarItem = UITabBarItem(title: "Profile",
                                                 image: Asset.userEmpty.image.preparingThumbnail(of: CGSize(width: 24, height: 24)),
                                                 selectedImage: Asset.userFilled.image.preparingThumbnail(of: CGSize(width: 25, height: 25)))
        }
        
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.backgroundColor = .appBackGroundColor
        tabBar.barTintColor = .appBackGroundColor
        tabBar.layer.cornerRadius = 30
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 8
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.clipsToBounds = false
        tabBar.tintColor = .systemOrange
        
        setViewControllers([homeNav, searchNav, favoritesNav, profileNav], animated: true)
        selectedIndex = 0
    }    
}


extension TabbarViewControllers: TabBarItemsSwicthDelegate {
    func switchItems(index: Int) {
        selectedIndex = index
    }
}
