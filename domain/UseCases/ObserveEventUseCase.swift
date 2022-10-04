//
//  ObserveEventUseCase.swift
//  domain
//
//  Created by Nazim Asadov on 26.09.22.
//

import Foundation
import RxSwift

public class ObserveEventUseCase {
    
    private let repo: EventRepoProtocol
    init(repo: EventRepoProtocol) {
        self.repo = repo
    }
    
    public func execute() -> Observable<InitialEvents> {
        return self.repo.observeEvents()
    }
}
