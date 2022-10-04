//
//  GetPagedEventsUseCase.swift
//  domain
//
//  Created by Nazim Asadov on 20.09.22.
//

import Foundation
import Promises

public class GetPagedEventsUseCase {
    
    let repo: EventRepoProtocol
    init (repo: EventRepoProtocol) {
        self.repo = repo
    }
    
    public func execute(name: String, page: Int) -> Promise<InitialEvents> {
        return repo.getPagedEvents(with: name, page: page)
    }
}
