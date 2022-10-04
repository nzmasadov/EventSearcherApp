//
//  GetClassificationEventsUseCase.swift
//  domain
//
//  Created by Nazim Asadov on 17.09.22.
//

import Foundation
import Promises

public class GetClassificationEventsUseCase {
    
    let repo: EventRepoProtocol
    init (repo: EventRepoProtocol) {
        self.repo = repo
    }
    
    public func execute(name: String) -> Promise<InitialEvents> {
        return repo.getClassificationEvents(with: name)
    }
}
