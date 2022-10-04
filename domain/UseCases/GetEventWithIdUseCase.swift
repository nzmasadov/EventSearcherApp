//
//  GetEventWithIdUseCase.swift
//  domain
//
//  Created by Nazim Asadov on 14.09.22.
//


import Foundation
import Promises

public class GetEventWithIdUseCase {
    
    let repo: EventRepoProtocol
    init (repo: EventRepoProtocol) {
        self.repo = repo
    }
    
    public func execute(id: String) -> Promise<EventResponse> {
        return repo.getEvent(with: id)
    }
}

