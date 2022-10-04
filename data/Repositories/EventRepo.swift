//
//  EventRepo.swift
//  data
//
//  Created by Nazim Asadov on 14.09.22.
//

import Foundation
import domain
import Promises
import RxSwift
import RxRelay


class EventRepo: EventRepoProtocol {

    

    private let eventRemoteDataSource: EventRemoteDataSourceProtocol
    private let eventLocalDataSource: EventLocalDataSourceProtocol
    init(eventRemoteDataSource: EventRemoteDataSourceProtocol,
         eventLocalDataSource: EventLocalDataSourceProtocol
    ) {
        self.eventRemoteDataSource = eventRemoteDataSource
        self.eventLocalDataSource = eventLocalDataSource
    }
    
    func syncEvents() -> Promise<Data> {
        let promise = Promise<Data>.pending()
        
        self.eventRemoteDataSource.getClassifications(with: "sport").then { initialEvents -> Promise<Data> in
            let local = initialEvents.toLocal()
            return self.eventLocalDataSource.save(events: local)
        }.then { void in
            promise.fulfill(void)
        }.catch { err in
            promise.reject(err)
        }
        return promise
    }
    
    func observeEvents() -> Observable<InitialEvents> {
        return self.eventLocalDataSource.observeEvents().map { dto in
            dto.toDomain()
        }
    }

    func getEvent(with id: String) -> Promise<EventResponse> {
        let promise = Promise<EventResponse>.pending()
        eventRemoteDataSource.getEventsWith(id: id).then { [weak self] event in
            guard let _ = self else {return}
            promise.fulfill(event.toDomain())
        }
        return promise
    }
    
    func getClassificationEvents(with name: String) -> Promise<InitialEvents> {
        let promise = Promise<InitialEvents>.pending()
        
        eventRemoteDataSource.getClassifications(with: name).then { [weak self] initialEvents in
            guard self != nil else {return}
            promise.fulfill(initialEvents.toDomain())
        }
        return promise
    }
    
    func getSearchedEvents(with text: String) -> Promise<InitialEvents> {
        let promise = Promise<InitialEvents>.pending()
        eventRemoteDataSource.getSearchedEvents(with: text).then { [weak self] event in
            guard self != nil else {return}
            promise.fulfill(event.toDomain())
        }
        return promise
    }
    
    func getPagedEvents(with name: String, page: Int) -> Promise<InitialEvents> {
        let promise = Promise<InitialEvents>.pending()
        eventRemoteDataSource.getPagedEvents(with: name, page: page).then { [weak self] initialEvents in
            guard self != nil else {return}
            promise.fulfill(initialEvents.toDomain())
        }
        return promise
    }
}
