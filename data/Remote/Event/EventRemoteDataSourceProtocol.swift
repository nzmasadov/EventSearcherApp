//
//  EventRemoteDataSourceProtocol.swift
//  data
//
//  Created by Nazim Asadov on 30.08.22.
//

import Foundation
import Promises

protocol EventRemoteDataSourceProtocol {
    func getEventsWith(id: String) -> Promise<EventDTO>
    func getClassifications(with name: String) -> Promise<InitialEventsDTO>
    func getSearchedEvents(with text: String) -> Promise<InitialEventsDTO>
    func getPagedEvents(with name: String, page: Int) -> Promise<InitialEventsDTO>
}
