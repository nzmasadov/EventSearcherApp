//
//  EventRepoMockData.swift
//  UseCaseTests
//
//  Created by Nazim Asadov on 04.10.22.
//

import Foundation
import Promises
import RxSwift

class EventRepoMockData: EventRepoProtocol {
    
    var getEvent = Promise<EventResponse>.pending()
    var getInitialEvent = Promise<InitialEvents>.pending()
    
    // nzm delete then
    var observeEventValue = PublishSubject<InitialEvents>.init()
    var syncEvent = Promise<Data>.pending()
    
    func getEvent(with id: String) -> Promise<EventResponse> {
        return getEvent
    }
        
    func getClassificationEvents(with name: String) -> Promise<InitialEvents> {
        return getInitialEvent
    }
    
    func getSearchedEvents(with text: String) -> Promise<InitialEvents> {
        return getInitialEvent
    }
    
    func getPagedEvents(with name: String, page: Int) -> Promise<InitialEvents>{
        return getInitialEvent
    }
    
    func syncEvents() -> Promise<Data> {
        return Promise<Data>.pending()
    }
    
    // nzm test
    func observeEvents() -> Observable<InitialEvents> {
        return observeEventValue.asObservable()
    }
}
