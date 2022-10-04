//
//  EventLocalDTO.swift
//  data
//
//  Created by Nazim Asadov on 25.09.22.
//

import Foundation
import RealmSwift
import domain

class EventLocalDTO: Object {
    @Persisted var name: String = ""
    @Persisted var price: String = ""
    @Persisted var date: String = ""
    @Persisted var arena: String = ""
    
    func toDomain() -> InitialEvents {
        return InitialEvents.init(events: InitialEvents.Events(events: []), pagesLinks: InitialEvents.PagedLinks(firstPage: InitialEvents.PagedLinks.Links(href: self.name), selfPage: InitialEvents.PagedLinks.Links(href: self.price), nextPage: InitialEvents.PagedLinks.Links(href: self.date), lastPage: InitialEvents.PagedLinks.Links(href: self.arena)), page: InitialEvents.Page(size: 1, totalElements: 2, totalPages: 3, number: 4))
    }
}
