//
//  FirstViewModel.swift
//  presentation
//
//  Created by Nazim Asadov on 29.08.22.
//

import UIKit
import domain
import Promises
import RxRelay
import RxSwift

public class FirstViewModel {

    private let getEventWithIdUseCase: GetEventWithIdUseCase
    private let getSearchedEventsUseCase: GetSearchedEventsUseCase
    private let getClassificationEventsUseCase: GetClassificationEventsUseCase
    private let syncEventsUseCase: SyncEventUseCase
    private let observeEventsUseCase: ObserveEventUseCase
        
    public init(getEventWithIdUseCase: GetEventWithIdUseCase, getSearchedEventsUseCase: GetSearchedEventsUseCase, getClassificationEventsUseCase: GetClassificationEventsUseCase,
        syncEventsUseCase: SyncEventUseCase,
        observeEventsUseCase: ObserveEventUseCase) {
        self.getEventWithIdUseCase = getEventWithIdUseCase
        self.getSearchedEventsUseCase = getSearchedEventsUseCase
        self.getClassificationEventsUseCase = getClassificationEventsUseCase
        self.syncEventsUseCase = syncEventsUseCase
        self.observeEventsUseCase = observeEventsUseCase
    }
    
    func observeEvents() -> Observable<InitialEvents> {
        return self.observeEventsUseCase.execute()
    }
    
    func syncEvents() {
        self.syncEventsUseCase.execute()
    }
    
    func getEvent(with id: String) -> Promise<EventResponse> {
        return getEventWithIdUseCase.execute(id: id)
    }
    
    func getClassificationEvents(with name: String) -> Promise<InitialEvents> {
        return getClassificationEventsUseCase.execute(name: name)
    }
    
    func getSearchedEvents(with text: String) -> Promise<InitialEvents> {
        return getSearchedEventsUseCase.execute(text: text)
    }
}
