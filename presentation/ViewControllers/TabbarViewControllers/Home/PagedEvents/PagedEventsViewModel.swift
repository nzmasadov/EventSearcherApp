//
//  AllEventsViewModel.swift
//  presentation
//
//  Created by Nazim Asadov on 20.09.22.
//

import Foundation
import domain
import Promises
public class PagedEventsViewModel {
    
    private let getPagedEventsUseCase: GetPagedEventsUseCase
    public init(getPagedEventsUseCase: GetPagedEventsUseCase) {
        self.getPagedEventsUseCase = getPagedEventsUseCase
    }
    
    func getPagedEvents(with name: String, page: Int) -> Promise<InitialEvents> {
        return getPagedEventsUseCase.execute(name: name, page: page)
    }
}
