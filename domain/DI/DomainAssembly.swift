//
//  DomainAssembly.swift
//  domain
//
//  Created by Nazim Asadov on 04.09.22.
//

import Foundation
import Swinject

public class DomainAssembly: Assembly {
    public init () {}
    
    public func assemble(container: Container) {
        
        container.register(GetEventWithIdUseCase.self) { r in
            GetEventWithIdUseCase.init(repo: r.resolve(EventRepoProtocol.self)!)
        }
        
        container.register(GetClassificationEventsUseCase.self) { r in
            GetClassificationEventsUseCase.init(repo: r.resolve(EventRepoProtocol.self)!)
        }
        
        container.register(GetSearchedEventsUseCase.self) { r in
            GetSearchedEventsUseCase.init(repo: r.resolve(EventRepoProtocol.self)!)
        }
        
        container.register(GetPagedEventsUseCase.self) { r in
            GetPagedEventsUseCase.init(repo: r.resolve(EventRepoProtocol.self)!)
        }
        
        container.register(SyncEventUseCase.self) { r in
            SyncEventUseCase(repo: r.resolve(EventRepoProtocol.self)!)
        }
        
        container.register(ObserveEventUseCase.self) { r in
            ObserveEventUseCase(repo: r.resolve(EventRepoProtocol.self)!)
        }
    }
}
