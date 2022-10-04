//
//  GetSearchedEventsUseCase.swift
//  domain
//
//  Created by Nazim Asadov on 16.09.22.
//

import Foundation
import Promises

public class GetSearchedEventsUseCase {
    
    let repo: EventRepoProtocol
    init (repo: EventRepoProtocol) {
        self.repo = repo
    }
    
    public func execute(text: String) -> Promise<InitialEvents> {
        repo.getSearchedEvents(with: text)
    }
}
