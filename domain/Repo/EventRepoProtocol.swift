//
//  EventRepoProtocol.swift
//  domain
//
//  Created by Nazim Asadov on 14.09.22.
//

import Foundation
import Promises
import RxSwift

public protocol EventRepoProtocol {
    func getEvent(with id: String) -> Promise<EventResponse>
    func getClassificationEvents(with name: String) -> Promise<InitialEvents>
    func getSearchedEvents(with text: String) -> Promise<InitialEvents>
    func getPagedEvents(with name: String, page: Int) -> Promise<InitialEvents>
    func syncEvents() -> Promise<Data>
    func observeEvents() -> Observable<InitialEvents>
}
