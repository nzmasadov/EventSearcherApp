//
//  PresentationAssembly.swift
//  presentation
//
//  Created by Nazim Asadov on 04.09.22.
//

import Foundation
import Swinject
import domain

public class PresentationAssembly: Assembly {
    public init () {}
    
    public func assemble(container: Container) {
        container.register(FirstViewModel.self) { r in
            return FirstViewModel(
                getEventWithIdUseCase: r.resolve(GetEventWithIdUseCase.self)!,
                getSearchedEventsUseCase: r.resolve(GetSearchedEventsUseCase.self)!,
                getClassificationEventsUseCase: r.resolve(GetClassificationEventsUseCase.self)!,
                syncEventsUseCase: r.resolve(SyncEventUseCase.self)!,
                observeEventsUseCase: r.resolve(ObserveEventUseCase.self)!
            )
        }
                
        container.register(LoginViewModel.self) { _ in
            return LoginViewModel()
        }
        
        container.register(SignUpViewModel.self) { _ in
            return SignUpViewModel()
        }
        container.register(AboutVM.self) { _ in
            return AboutVM()
        }
        
        container.register(PagedEventsViewModel.self) { r in
            return PagedEventsViewModel(getPagedEventsUseCase: r.resolve(GetPagedEventsUseCase.self)!)
        }
    }
}
