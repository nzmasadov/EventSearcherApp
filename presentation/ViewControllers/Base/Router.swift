//
//  Router.swift
//  presentation
//
//  Created by Nazim Asadov on 29.08.22.
//

import Foundation
import Swinject

public protocol RouterProtocol {
    func tabbarViewControllers() -> TabbarViewControllers
    func homeViewController() -> HomeViewController
    func searchViewController() -> SearchViewController
    func favoritesViewController() -> FavoritesViewController
    func profileViewController() -> ProfileViewController
    func loginViewController() -> LoginViewController
    func signupViewController() -> SignUpViewController
    func pagedEventsViewController() -> PagedEventsViewController
    func aboutVC() -> AboutVC
    func privacyVC() -> PrivacyVC
    func webViewVC() -> WebViewVC
}

public class Router: RouterProtocol {
    
    private let resolver: Resolver
    public init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    public func tabbarViewControllers() -> TabbarViewControllers {
        let tabbar = TabbarViewControllers(
            vm: resolver.resolve(FirstViewModel.self)!,
            router: self
        )
        return tabbar
    }
    
    public func homeViewController() -> HomeViewController{
        let vc = HomeViewController()
        vc.vm = resolver.resolve(FirstViewModel.self)
        vc.router = self
        return vc
    }
    
    public func searchViewController() -> SearchViewController {
        let vc = SearchViewController()
        vc.vm = resolver.resolve(FirstViewModel.self)
        vc.router = self
        return vc
    }
    
    public func favoritesViewController() -> FavoritesViewController {
        let vc = FavoritesViewController()
        vc.vm = resolver.resolve(FirstViewModel.self)
        vc.router = self
        return vc
    }
    
    public func profileViewController() -> ProfileViewController {
        let vc = ProfileViewController()
        vc.vm = resolver.resolve(FirstViewModel.self)
        vc.router = self
        return vc
    }
    
    public func pagedEventsViewController() -> PagedEventsViewController{
        let vc = PagedEventsViewController()
        vc.vm = resolver.resolve(PagedEventsViewModel.self)
        vc.router = self
        return vc
    }
//    public func pagedEventsViewController(type: EventsType.EventCategories) -> PagedEventsViewController{
//        let vc = PagedEventsViewController(eventType: type)
//        vc.vm = resolver.resolve(PagedEventsViewModel.self)
//        vc.router = self
//        return vc
//    }
    
    public func loginViewController() -> LoginViewController {
        let vc = LoginViewController()
        vc.vm = resolver.resolve(LoginViewModel.self)
        vc.router = self
        return vc
    }
    
    public func signupViewController() -> SignUpViewController {
        let vc = SignUpViewController()
        vc.vm = resolver.resolve(SignUpViewModel.self)
        vc.router = self
        return vc
    }
    
    public func aboutVC() -> AboutVC {
        let vc = AboutVC()
        vc.vm = resolver.resolve(AboutVM.self)
        vc.router = self
        return vc
    }
    
    public func privacyVC() -> PrivacyVC {
        let vc = PrivacyVC()
        vc.vm = resolver.resolve(PrivacyVM.self)
        vc.router = self
        return vc
    }
    
    public func webViewVC() -> WebViewVC {
        let vc = WebViewVC()
        vc.vm = resolver.resolve(WebViewModel.self)
        vc.router = self
        return vc
    }
}
