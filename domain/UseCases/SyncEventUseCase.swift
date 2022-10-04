//
//  SyncEventUseCase.swift
//  domain
//
//  Created by Nazim Asadov on 26.09.22.
//

import Foundation
import Promises

public class SyncEventUseCase {
  
    private let repo: EventRepoProtocol    
    init(repo: EventRepoProtocol) {
        self.repo = repo
    }
    
    public func execute() -> Promise<Data> {
        return self.repo.syncEvents()
    }
}
