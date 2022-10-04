//
//  Mapper.swift
//  data
//
//  Created by Nazim Asadov on 30.08.22.
//

import Foundation
import domain

// MARK: - VenueDTO
extension EventDTO.EmbeddedDTO.VenueDTO.LocationDTO {
    func toDomain() -> EventResponse.Embedded.Venue.Location {
        return EventResponse.Embedded.Venue.Location(longitude: self.longitude.orEmpty(), latitude: self.latitude.orEmpty())
    }
}

extension EventDTO.EmbeddedDTO.VenueDTO.GeneralInfoDTO {
    func toDomain() -> EventResponse.Embedded.Venue.GeneralInfo {
        return EventResponse.Embedded.Venue.GeneralInfo(generalRule: self.generalRule.orEmpty(), childRule: self.childRule.orEmpty())
    }
}

extension EventDTO.EmbeddedDTO.VenueDTO.AddressDTO {
    func toDomain() -> EventResponse.Embedded.Venue.Address {
        return EventResponse.Embedded.Venue.Address(line1: self.line1.orEmpty())
    }
}

extension EventDTO.EmbeddedDTO.VenueDTO.CountryDTO {
    func toDomain() -> EventResponse.Embedded.Venue.Country {
        return EventResponse.Embedded.Venue.Country(name: self.name.orEmpty(), countryCode: self.countryCode.orEmpty())
    }
}

extension EventDTO.EmbeddedDTO.VenueDTO.StateDTO {
    func toDomain() -> EventResponse.Embedded.Venue.State {
        return EventResponse.Embedded.Venue.State(name: self.name.orEmpty(), stateCode: self.stateCode.orEmpty())
    }
}

extension EventDTO.EmbeddedDTO.VenueDTO.CityDTO {
    func toDomain() -> EventResponse.Embedded.Venue.City {
        return EventResponse.Embedded.Venue.City(name: self.name.orEmpty())
    }
}

extension EventDTO.EmbeddedDTO.VenueDTO {
    
    func toDomain() -> EventResponse.Embedded.Venue {
        return EventResponse.Embedded.Venue(
            name: self.name.orEmpty(),
            type: self.type.orEmpty(),
            id: self.id.orEmpty(),
            url: self.url.orEmpty(),
            locale: self.locale.orEmpty(),
            images: self.images.map({ $0.map { $0.toDomain()}}) ?? [],
            city: self.city.map({ $0.toDomain()}) ?? EventResponse.Embedded.Venue.City(name: ""),
            state: self.state.map({ $0.toDomain()}) ?? EventResponse.Embedded.Venue.State(name: "", stateCode: ""),
            country: self.country.map({ $0.toDomain()}) ?? EventResponse.Embedded.Venue.Country(name: "", countryCode: ""),
            address: self.address.map({ $0.toDomain()}) ?? EventResponse.Embedded.Venue.Address(line1: "") ,
            location: self.location.map({ $0.toDomain()}) ?? EventResponse.Embedded.Venue.Location(longitude: "", latitude: ""),
            parkingDetail: self.parkingDetail.orEmpty(),
            accessibleSeatingDetail: self.accessibleSeatingDetail.orEmpty(),
            generalInfo: self.generalInfo.map({ $0.toDomain()}) ?? EventResponse.Embedded.Venue.GeneralInfo(generalRule: "", childRule: "")
        )
    }
}

// MARK: - EventDTO
extension EventDTO.DatesDTO.StatusDTO {
    func toDomain() -> EventResponse.Dates.Status {
        return EventResponse.Dates.Status(code: self.code.orEmpty())
    }
}

extension EventDTO.DatesDTO.StartDTO {
    func toDomain() -> EventResponse.Dates.Start {
        return EventResponse.Dates.Start(localDate: self.localDate.orEmpty(), localTime: self.localTime.orEmpty(), dateTime: self.dateTime.orEmpty())
    }
}

extension EventDTO.ClassificationDTO.GenreDTO {
    func toDomain() -> EventResponse.Classification.Genre {
        return EventResponse.Classification.Genre(name: self.name.orEmpty())
    }
}

extension EventDTO.EmbeddedDTO {
    func toDomain() -> EventResponse.Embedded {
        return .init(venues: self.venues.map({ $0.map { $0.toDomain()}}) ?? [])
    }
}

extension EventDTO.AgeRestrictionsDTO {
    func toDomain() -> EventResponse.AgeRestrictions {
        return .init(legalAgeEnforced: self.legalAgeEnforced ?? false)
    }
}

extension EventDTO.TicketLimitDTO {
    func toDomain() -> EventResponse.TicketLimit {
        return .init(info: self.info.orEmpty())
    }
}
extension EventDTO.SeatmapDTO {
    func toDomain() -> EventResponse.Seatmap {
        return .init(staticUrl: self.staticUrl.orEmpty())
    }
}
extension EventDTO.PriceRangeDTO {
    func toDomain() -> EventResponse.PriceRange {
        return .init(currency: self.currency.orEmpty(), min: min ?? 0.0, max: max ?? 0.0)
//            var min = Double(truncating: self.min as! NSNumber)
//            var max = Double(truncating: self.max as! NSNumber)
//            if let doubleMin = Double(truncating: self.min as! NSNumber) {
//                min = doubleMin
//            } else {
//                min = Double(Int(truncating: self.min as! NSNumber))
//            }
//
//            if let doubleMax = Double(truncating: self.max as! NSNumber) {
//                max = doubleMax
//            } else {
//                max = Double(Int(truncating: self.max as! NSNumber)) ?? 0.0
//            }
    }
}
extension EventDTO.ClassificationDTO {
    func toDomain() -> EventResponse.Classification {
        return .init(segment: (self.segment?.toDomain()) ?? EventResponse.Classification.Genre(name: ""), genre: (self.genre?.toDomain())  ?? EventResponse.Classification.Genre(name: ""), subGenre: (self.subGenre?.toDomain()) ?? EventResponse.Classification.Genre(name: ""))
    }
}
extension EventDTO.DatesDTO {
    func toDomain() -> EventResponse.Dates {
        return .init(start: (self.start?.toDomain()) ?? EventResponse.Dates.Start(localDate: "", localTime: "", dateTime: ""), status: (self.status?.toDomain()) ?? EventResponse.Dates.Status(code: ""))
    }
}

extension EventDTO.ImageDTO {
    func toDomain() -> EventResponse.Image {
        return.init(ratio: self.ratio.orEmpty(), url: self.url.orEmpty(), width: self.width ?? 0 , height: self.height ?? 0)
    }
}

extension EventDTO {
    func toDomain() -> EventResponse {
        return .init(name: self.name.orEmpty(), type: self.type.orEmpty(), id: self.id.orEmpty(), url: self.url.orEmpty(), images: self.images.map({ $0.map { $0.toDomain()}}) ?? [], dates: (self.dates?.toDomain()) ?? EventResponse.Dates(start: EventResponse.Dates.Start(localDate: "", localTime: "", dateTime: ""), status: EventResponse.Dates.Status(code: "")), classifications: self.classifications.map({ $0.map { $0.toDomain()}}) ?? [], info: self.info.orEmpty(), pleaseNote: self.pleaseNote.orEmpty(), priceRanges: self.priceRanges.map({ $0.map { $0.toDomain()}}) ?? [], seatmap: (self.seatmap?.toDomain()) ?? EventResponse.Seatmap(staticUrl: ""), ticketLimit: (self.ticketLimit?.toDomain()) ?? EventResponse.TicketLimit(info: ""), ageRestriction: (self.ageRestrictions?.toDomain()) ?? EventResponse.AgeRestrictions.init(legalAgeEnforced: false), _embedded: (self._embedded?.toDomain()) ?? EventResponse.Embedded.init(venues: [])
        )
    }
}

// MARK: - InitialsEventsDTO
extension InitialEventsDTO.PagedLinksDTO.LinksDTO {
    func toDomain() -> InitialEvents.PagedLinks.Links {
        .init(href: self.href.orEmpty())
    }
}

extension InitialEventsDTO.PageDTO {
    func toDomain() -> InitialEvents.Page{
        .init(size: self.size ?? -1, totalElements: self.totalElements ?? -1, totalPages: self.totalPages ?? -1, number: self.number ?? -1)
    }
}

extension InitialEventsDTO.PagedLinksDTO {
    func toDomain() -> InitialEvents.PagedLinks {
        return InitialEvents.PagedLinks.init(
            firstPage: self.firstPage.map({ $0.toDomain()}) ?? InitialEvents.PagedLinks.Links(href: ""),
            selfPage: self.selfPage.map({ $0.toDomain()}) ?? InitialEvents.PagedLinks.Links(href: ""),
            nextPage: self.nextPage.map({ $0.toDomain()}) ?? InitialEvents.PagedLinks.Links(href: ""),
            lastPage: self.lastPage.map({ $0.toDomain()}) ?? InitialEvents.PagedLinks.Links(href: ""))
    }
}

extension InitialEventsDTO.EventsDTO {
    func toDomain() -> InitialEvents.Events {
        return .init(events: self.events.map({ $0.map { $0.toDomain()}}) ?? [])}
}

extension InitialEventsDTO {
    func toLocal() -> EventLocalDTO {
        var local = EventLocalDTO()
        local.name = self.pagedLinks?.toDomain().lastPage.href ?? ""
        local.date = self.pagedLinks?.toDomain().firstPage.href ?? ""
        local.arena = self.pagedLinks?.toDomain().nextPage.href ?? ""
        local.price = self.pagedLinks?.toDomain().selfPage.href ?? ""
        return local
    }
    
    func toDomain() -> InitialEvents {
        return .init(events: self.events.map({ $0.toDomain()}) ?? InitialEvents.Events(events: []), pagesLinks: self.pagedLinks.map({ $0.toDomain()}) ?? InitialEvents.PagedLinks(firstPage: InitialEvents.PagedLinks.Links(href: ""), selfPage: InitialEvents.PagedLinks.Links(href: ""), nextPage: InitialEvents.PagedLinks.Links(href: ""), lastPage: InitialEvents.PagedLinks.Links(href: "")), page: self.page.map({ $0.toDomain()}) ?? InitialEvents.Page(size: 0, totalElements: 0, totalPages: 0, number: 0))
    }
}
