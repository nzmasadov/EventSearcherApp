//
//  EventLocalDataSource.swift
//  data
//
//  Created by Nazim Asadov on 25.09.22.
//

import Foundation
import RxRelay
import Promises
import RealmSwift
import RxSwift

class EventLocalDataSource: EventLocalDataSourceProtocol {
 
    private let realm: Realm
    private let eventsRelay = BehaviorRelay<EventLocalDTO?>.init(value: nil)
    
    init(realm: Realm) {
        self.realm = realm
        
    }
        
    
    func save(events: EventLocalDTO) -> Promise<Data> {
        let promise = Promise<Data>.pending()
        
        let oldObjects = self.realm.objects(EventLocalDTO.self)
        
        do {
            try realm.write {
                realm.delete(oldObjects)
            }
            try realm.write {
                realm.add(events)
            }
            
            self.eventsRelay.accept(events)
            promise.fulfill(Data())
            
        }catch {
            promise.reject(error)
        }
        return promise
    }
    
    // nzm look at here
    func observeEvents() -> Observable<EventLocalDTO> {
        return self.eventsRelay
            .filter({ dto in
                dto != nil
            })
            .map({ dto in
                dto!
            })
            .asObservable()
    }
    
//    func getEvents() -> [EventLocalDTO] {
//        return self.realm.objects(EventLocalDTO.self)
//            .freeze()
//            .map { (item) -> EventLocalDTO in
//                item
//        }
//    }
//    private func syncEvents() {
//        let events = self.getEvents()
//        self.eventsRelay.accept(events)
//    }
//
//    func save(events: [EventLocalDTO]) -> Promise<Data> {
//        let promise = Promise<Data>.pending()
//
//        do {
//            let cached = self.realm.objects(EventLocalDTO.self)
//
//            try self.realm.write {
//                self.realm.delete(cached)
//                self.realm.add(events, update: .modified)
//            }
//
//            self.syncEvents()
//            promise.fulfill(Data())
//        } catch {
//            promise.reject(error)
//        }
//
//        return promise
//    }
//
//    func observeEvents() -> Observable<[EventLocalDTO]> {
//        return eventsRelay.asObservable()
//    }
}
