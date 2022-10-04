//
//  EventLocalDataSourceProtocol.swift
//  data
//
//  Created by Nazim Asadov on 25.09.22.
//

import Foundation
import RxSwift
import Promises

protocol EventLocalDataSourceProtocol {
    func observeEvents() -> Observable<EventLocalDTO>
    func save(events: EventLocalDTO) -> Promise<Data>
}
