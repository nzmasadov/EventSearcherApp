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

//public class InitialEventsLocalDTO: Object{
//    @Persisted var events: EventsLocalDTO
//    @Persisted var pagedLinks: PagedLinksLocalDTO
//    @Persisted var page: PageLocalDTO
//
//
//    func toDomain() -> InitialEvents {
//        return .init(events: <#T##InitialEvents.Events#>, pagesLinks: InitialEventsLocalDTO.PagedLinksLocalDTO.init(firstPage: PagedLinksLocalDTO.LinksLocalDTO.init(href: ), selfPage: <#T##PagedLinksLocalDTO.LinksLocalDTO#>, nextPage: <#T##PagedLinksLocalDTO.LinksLocalDTO#>, lastPage: <#T##PagedLinksLocalDTO.LinksLocalDTO#>), page: <#T##InitialEvents.Page#>)
//    }
//}
//
//extension InitialEventsLocalDTO {
//
//    public convenience init(events: InitialEventsLocalDTO.EventsLocalDTO, pagesLinks: InitialEventsLocalDTO.PagedLinksLocalDTO, page: InitialEventsLocalDTO.PageLocalDTO) {
//        self.init()
//        self.events = events
//        self.pagedLinks = pagesLinks
//        self.page = page
//    }
//
//    public class EventsLocalDTO: Object{
//        @Persisted var events: List<EventResponseLocalDTO>
//
//        public init(events: List<EventResponseLocalDTO>) {
//            self.events = events
//        }
//    }
//
//    public class PagedLinksLocalDTO: Object {
//        @Persisted var firstPage: LinksLocalDTO
//        @Persisted var selfPage: LinksLocalDTO
//        @Persisted var nextPage: LinksLocalDTO
//        @Persisted var lastPage: LinksLocalDTO
//        public init(firstPage: InitialEventsLocalDTO.PagedLinksLocalDTO.LinksLocalDTO,
//                    selfPage: InitialEventsLocalDTO.PagedLinksLocalDTO.LinksLocalDTO,
//                    nextPage: InitialEventsLocalDTO.PagedLinksLocalDTO.LinksLocalDTO,
//                    lastPage: InitialEventsLocalDTO.PagedLinksLocalDTO.LinksLocalDTO) {
//            self.firstPage = firstPage
//            self.selfPage = selfPage
//            self.nextPage = nextPage
//            self.lastPage = lastPage
//        }
//    }
//
//    public class PageLocalDTO:Object {
//        @Persisted var size: Int
//        @Persisted var totalElements: Int
//        @Persisted var totalPages: Int
//        @Persisted var number: Int
//
//        public init(size: Int, totalElements: Int, totalPages: Int, number: Int) {
//            self.size = size
//            self.totalElements = totalElements
//            self.totalPages = totalPages
//            self.number = number
//        }
//    }
//}
//
//extension InitialEventsLocalDTO.PagedLinksLocalDTO {
//    public class LinksLocalDTO: Object {
//
//        @Persisted var href: String
//
//        public init(href: String) {
//            self.href = href
//        }
//    }
//}
//
//public class EventResponseLocalDTO: Object {
//
//    @Persisted var name: String
//    @Persisted var type: String
//    @Persisted var id: String
//    @Persisted var url: String
//    @Persisted var images: List<ImageLocalDTO>
//    @Persisted var dates: DatesLocalDTO
//    @Persisted var classifications: List<ClassificationLocalDTO>
//    @Persisted var info: String
//    @Persisted var pleaseNote: String
//    @Persisted var priceRanges: List<PriceRangeLocalDTO>
//    @Persisted var seatmap: SeatmapLocalDTO
//    @Persisted var ticketLimit: TicketLimitLocalDTO
//    @Persisted var ageRestrictions: AgeRestrictionsLocalDTO
//    @Persisted var _embedded: EmbeddedLocalDTO
//}
//
//extension EventResponseLocalDTO {
//
//    public convenience init(name: String, type: String, id: String, url: String, images: List<EventResponseLocalDTO.ImageLocalDTO>, dates: EventResponseLocalDTO.DatesLocalDTO, classifications: List<EventResponseLocalDTO.ClassificationLocalDTO>, info: String, pleaseNote: String, priceRanges: List<EventResponseLocalDTO.PriceRangeLocalDTO>, seatmap: EventResponseLocalDTO.SeatmapLocalDTO, ticketLimit: EventResponseLocalDTO.TicketLimitLocalDTO, ageRestriction: EventResponseLocalDTO.AgeRestrictionsLocalDTO, _embedded: EventResponseLocalDTO.EmbeddedLocalDTO) {
//        self.init()
//        self.name = name
//        self.type = type
//        self.id = id
//        self.url = url
//        self.images = images
//        self.dates = dates
//        self.classifications = classifications
//        self.info = info
//        self.pleaseNote = pleaseNote
//        self.priceRanges = priceRanges
//        self.seatmap = seatmap
//        self.ticketLimit = ticketLimit
//        self.ageRestrictions = ageRestriction
//        self._embedded = _embedded
//    }
//
//    // MARK: - Image
//    public class ImageLocalDTO: Object{
//        @Persisted var ratio: String  // "16_9", "3_2", "4_3"
//        @Persisted var url: String
//        @Persisted var width: Int
//        @Persisted var height: Int
//
//        public init (ratio: String, url: String, width: Int, height: Int) {
//            self.ratio = ratio
//            self.url = url
//            self.width = width
//            self.height = height
//        }
//    }
//
//    // MARK: - Dates
//    public class DatesLocalDTO: Object{
//        @Persisted var start: StartLocalDTO
//        @Persisted var status: StatusLocalDTO
//
//        public init(start: EventResponseLocalDTO.DatesLocalDTO.StartLocalDTO, status: EventResponseLocalDTO.DatesLocalDTO.StatusLocalDTO) {
//            self.start = start
//            self.status = status
//        }
//    }
//
//    // MARK: - Classification
//    public class ClassificationLocalDTO: Object{
//        @Persisted var segment: GenreLocalDTO
//        @Persisted var genre: GenreLocalDTO
//        @Persisted var subGenre: GenreLocalDTO
//
//        public init(segment: EventResponseLocalDTO.ClassificationLocalDTO.GenreLocalDTO, genre: EventResponseLocalDTO.ClassificationLocalDTO.GenreLocalDTO, subGenre: EventResponseLocalDTO.ClassificationLocalDTO.GenreLocalDTO) {
//            self.segment = segment
//            self.genre = genre
//            self.subGenre = subGenre
//        }
//    }
//
//    // MARK: - PriceRange
//    public class PriceRangeLocalDTO: Object{
//        @Persisted var currency: String
//        @Persisted var min: Double
//        @Persisted var max: Double
//
//        public init (currency: String, min: Double, max: Double) {
//            self.currency = currency
//            self.min = min
//            self.max = max
//        }
//    }
//
//
//    // MARK: - Seatmap
//    public class SeatmapLocalDTO: Object{
//
//        @Persisted var staticUrl: String
//        public init (staticUrl: String) {
//            self.staticUrl = staticUrl
//        }
//    }
//
//
//    // MARK: - TicketLimit
//    public class TicketLimitLocalDTO: Object{
//        @Persisted var info: String
//
//        public init (info: String) {
//            self.info = info
//        }
//    }
//
//    // MARK: - AgeRestrictions
//    public class AgeRestrictionsLocalDTO: Object{
//        @Persisted var legalAgeEnforced: Bool
//
//        public init(legalAgeEnforced: Bool) {
//            self.legalAgeEnforced = legalAgeEnforced
//        }
//    }
//
//    // MARK: - Embedded
//    public class EmbeddedLocalDTO: Object{
//        @Persisted var venues: List<VenueLocalDTO>
//        public init(venues: List<EventResponseLocalDTO.EmbeddedLocalDTO.VenueLocalDTO>) {
//            self.venues = venues
//        }
//    }
//}
//
//extension EventResponseLocalDTO.DatesLocalDTO {
//    // MARK: - Start
//    public class StartLocalDTO: Object{
//        @Persisted var localDate:String
//        @Persisted var localTime: String
//        @Persisted var dateTime: String
//
//        public init (localDate: String, localTime: String, dateTime: String ) {
//            self.localDate = localDate
//            self.localTime = localTime
//            self.dateTime = dateTime
//        }
//    }
//
//    // MARK: - Status
//    public class StatusLocalDTO: Object{
//        @Persisted var code: String
//
//        public init (code: String) {
//            self.code = code
//        }
//    }
//}
//
//extension EventResponseLocalDTO.ClassificationLocalDTO {
//    public class GenreLocalDTO: Object{
//        @Persisted var name: String
//
//        public init(name: String) {
//            self.name = name
//        }
//    }
//}
//
//extension EventResponseLocalDTO.EmbeddedLocalDTO {
//    // MARK: - Venue
//    public class VenueLocalDTO: Object{
//        @Persisted var name: String
//        @Persisted var type: String
//        @Persisted var id: String
//        @Persisted var url: String
//        @Persisted var locale: String
//        @Persisted var images: List<EventResponseLocalDTO.ImageLocalDTO>
//        @Persisted var city: CityLocalDTO
//        @Persisted var state: StateLocalDTO
//        @Persisted var country: CountryLocalDTO
//        @Persisted var address: AddressLocalDTO
//        @Persisted var location: LocationLocalDTO
//        @Persisted var parkingDetail: String
//        @Persisted var accessibleSeatingDetail: String
//        @Persisted var generalInfo: GeneralInfoLocalDTO
//
//        public init(name: String, type: String, id: String, url: String, locale: String, images: List<EventResponseLocalDTO.ImageLocalDTO>, city: EventResponseLocalDTO.EmbeddedLocalDTO.VenueLocalDTO.CityLocalDTO, state: EventResponseLocalDTO.EmbeddedLocalDTO.VenueLocalDTO.StateLocalDTO, country: EventResponseLocalDTO.EmbeddedLocalDTO.VenueLocalDTO.CountryLocalDTO, address: EventResponseLocalDTO.EmbeddedLocalDTO.VenueLocalDTO.AddressLocalDTO, location: EventResponseLocalDTO.EmbeddedLocalDTO.VenueLocalDTO.LocationLocalDTO, parkingDetail: String, accessibleSeatingDetail: String, generalInfo: EventResponseLocalDTO.EmbeddedLocalDTO.VenueLocalDTO.GeneralInfoLocalDTO) {
//            self.name = name
//            self.type = type
//            self.id = id
//            self.url = url
//            self.locale = locale
//            self.images = images
//            self.city = city
//            self.state = state
//            self.country = country
//            self.address = address
//            self.location = location
//            self.parkingDetail = parkingDetail
//            self.accessibleSeatingDetail = accessibleSeatingDetail
//            self.generalInfo = generalInfo
//        }
//    }
//}
//
//extension EventResponseLocalDTO.EmbeddedLocalDTO.VenueLocalDTO {
//    // MARK: - City
//    public class CityLocalDTO: Object{
//        @Persisted var name: String
//
//        public init (name: String) {
//            self.name = name
//        }
//    }
//
//    // MARK: - State
//    public class StateLocalDTO: Object {
//        @Persisted var name: String
//        @Persisted var stateCode: String
//
//        public init (name: String, stateCode: String) {
//            self.name = name
//            self.stateCode = stateCode
//        }
//    }
//
//    // MARK: - Country
//    public class CountryLocalDTO: Object{
//        @Persisted var name: String
//        @Persisted var countryCode: String
//
//        public init (name: String, countryCode: String) {
//            self.name = name
//            self.countryCode = countryCode
//        }
//    }
//
//    // MARK: - Address
//    public class AddressLocalDTO: Object{
//        @Persisted var line1: String
//
//        public init (line1: String) {
//            self.line1 = line1
//        }
//    }
//
//    // MARK: - Location
//    public class LocationLocalDTO: Object{
//        @Persisted var longitude: String
//        @Persisted var latitude: String
//
//        public init (longitude: String, latitude: String) {
//            self.longitude = longitude
//            self.latitude = latitude
//        }
//    }
//
//    // MARK: - GeneralInfo
//    public class GeneralInfoLocalDTO: Object{
//        @Persisted var generalRule: String
//        @Persisted var childRule: String
//
//        public init (generalRule: String, childRule: String) {
//            self.generalRule = generalRule
//            self.childRule = childRule
//        }
//    }
//}
