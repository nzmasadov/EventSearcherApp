//
//  EventEntity.swift
//  domain
//
//  Created by Nazim Asadov on 14.09.22.
//

import Foundation

public struct InitialEvents: Equatable{
    public static func == (lhs: InitialEvents, rhs: InitialEvents) -> Bool {
        lhs.pagedLinks.firstPage == rhs.pagedLinks.firstPage
    }
    
    public let events: Events
    public let pagedLinks: PagedLinks
    public let page: Page
}

extension InitialEvents {
    
    public init(events: InitialEvents.Events, pagesLinks: InitialEvents.PagedLinks, page: InitialEvents.Page) {
        self.events = events
        self.pagedLinks = pagesLinks
        self.page = page
    }
    
    public struct Events{
        public let events: [EventResponse]
        
        public init(events: [EventResponse]) {
            self.events = events
        }
    }
    
    public struct PagedLinks {
        public let firstPage, selfPage, nextPage, lastPage: Links
        
        public init(firstPage: InitialEvents.PagedLinks.Links,
                    selfPage: InitialEvents.PagedLinks.Links,
                    nextPage: InitialEvents.PagedLinks.Links,
                    lastPage: InitialEvents.PagedLinks.Links) {
            self.firstPage = firstPage
            self.selfPage = selfPage
            self.nextPage = nextPage
            self.lastPage = lastPage
        }
    }
    
    public struct Page {
        public let size, totalElements, totalPages, number: Int
        
        public init(size: Int, totalElements: Int, totalPages: Int, number: Int) {
            self.size = size
            self.totalElements = totalElements
            self.totalPages = totalPages
            self.number = number
        }
    }
}

extension InitialEvents.PagedLinks {
    
    public struct Links: Equatable {
        public static func == (lhs: InitialEvents.PagedLinks.Links, rhs: InitialEvents.PagedLinks.Links) -> Bool {
            lhs.href == rhs.href
        }
        public let href: String
        
        public init(href: String) {
            self.href = href
        }
    }
}

public struct EventResponse: Equatable {
    public static func == (lhs: EventResponse, rhs: EventResponse) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    public let name, type, id: String
    public let url: String
    public let images: [Image]
    public let dates: Dates
    public let classifications: [Classification]
    public let info: String
    public let pleaseNote: String
    public let priceRanges: [PriceRange]
    public let seatmap: Seatmap
    public let ticketLimit: TicketLimit
    public let ageRestrictions: AgeRestrictions
    public let _embedded: Embedded
}

extension EventResponse {
    
    public init(name: String, type: String, id: String, url: String, images: [EventResponse.Image], dates: EventResponse.Dates, classifications: [EventResponse.Classification], info: String, pleaseNote: String, priceRanges: [EventResponse.PriceRange], seatmap: EventResponse.Seatmap, ticketLimit: EventResponse.TicketLimit, ageRestriction: EventResponse.AgeRestrictions, _embedded: EventResponse.Embedded) {
        self.name = name
        self.type = type
        self.id = id
        self.url = url
        self.images = images
        self.dates = dates
        self.classifications = classifications
        self.info = info
        self.pleaseNote = pleaseNote
        self.priceRanges = priceRanges
        self.seatmap = seatmap
        self.ticketLimit = ticketLimit
        self.ageRestrictions = ageRestriction
        self._embedded = _embedded
    }
    
    // MARK: - Image
    public struct Image{
        public let ratio: String  // "16_9", "3_2", "4_3"
        public let url: String
        public let width, height: Int
        
        public init (ratio: String, url: String, width: Int, height: Int) {
            self.ratio = ratio
            self.url = url
            self.width = width
            self.height = height
        }
    }
    
    // MARK: - Dates
    public struct Dates{
        public let start: Start
        public let status: Status
        
        public init(start: EventResponse.Dates.Start, status: EventResponse.Dates.Status) {
            self.start = start
            self.status = status
        }
    }
    
    // MARK: - Classification
    public struct Classification{
        public let segment, genre, subGenre: Genre
        
        public init(segment: EventResponse.Classification.Genre, genre: EventResponse.Classification.Genre, subGenre: EventResponse.Classification.Genre) {
            self.segment = segment
            self.genre = genre
            self.subGenre = subGenre
        }
    }
    
    // MARK: - PriceRange
    public struct PriceRange{
        public let currency: String
        public let min, max: Double
        
        public init (currency: String, min: Double, max: Double) {
            self.currency = currency
            self.min = min
            self.max = max
        }
    }
    
    
    // MARK: - Seatmap
    public struct Seatmap{
        
        public let staticUrl: String
        public init (staticUrl: String) {
            self.staticUrl = staticUrl
        }
    }
    
    
    // MARK: - TicketLimit
    public struct TicketLimit{
        public let info: String
        
        public init (info: String) {
            self.info = info
        }
    }
    
    // MARK: - AgeRestrictions
    public struct AgeRestrictions{
        public let legalAgeEnforced: Bool
        
        public init(legalAgeEnforced: Bool) {
            self.legalAgeEnforced = legalAgeEnforced
        }
    }
    
    // MARK: - Embedded
    public struct Embedded{
        public let venues: [Venue]
        public init(venues: [EventResponse.Embedded.Venue]) {
            self.venues = venues
        }
    }
}

extension EventResponse.Dates {
    // MARK: - Start
    public struct Start{
        public let localDate, localTime: String
        public let dateTime: String
        
        public init (localDate: String, localTime: String, dateTime: String ) {
            self.localDate = localDate
            self.localTime = localTime
            self.dateTime = dateTime
        }
    }
    
    // MARK: - Status
    public struct Status{
        public let code: String
        
        public init (code: String) {
            self.code = code
        }
    }
}

extension EventResponse.Classification {
    public struct Genre{
        public let name: String
        
        public init(name: String) {
            self.name = name
        }
    }
}

extension EventResponse.Embedded {
    // MARK: - Venue
    public struct Venue{
        public let name, type, id: String
        public let url: String
        public let locale: String
        public let images: [EventResponse.Image]
        public let city: City
        public let state: State
        public let country: Country
        public let address: Address
        public let location: Location
        public let parkingDetail, accessibleSeatingDetail: String
        public let generalInfo: GeneralInfo
        
        public init(name: String, type: String, id: String, url: String, locale: String, images: [EventResponse.Image], city: EventResponse.Embedded.Venue.City, state: EventResponse.Embedded.Venue.State, country: EventResponse.Embedded.Venue.Country, address: EventResponse.Embedded.Venue.Address, location: EventResponse.Embedded.Venue.Location, parkingDetail: String, accessibleSeatingDetail: String, generalInfo: EventResponse.Embedded.Venue.GeneralInfo) {
            self.name = name
            self.type = type
            self.id = id
            self.url = url
            self.locale = locale
            self.images = images
            self.city = city
            self.state = state
            self.country = country
            self.address = address
            self.location = location
            self.parkingDetail = parkingDetail
            self.accessibleSeatingDetail = accessibleSeatingDetail
            self.generalInfo = generalInfo
        }
    }
}

extension EventResponse.Embedded.Venue {
    // MARK: - City
    public struct City{
        public let name: String
        
        public init (name: String) {
            self.name = name
        }
    }
    
    // MARK: - State
    public struct State {
        public let name, stateCode: String
        
        public init (name: String, stateCode: String) {
            self.name = name
            self.stateCode = stateCode
        }
    }
    
    // MARK: - Country
    public struct Country{
        public let name, countryCode: String
        
        public init (name: String, countryCode: String) {
            self.name = name
            self.countryCode = countryCode
        }
    }
    
    // MARK: - Address
    public struct Address{
        public let line1: String
        
        public init (line1: String) {
            self.line1 = line1
        }
    }
    
    // MARK: - Location
    public struct Location{
        public let longitude, latitude: String
        
        public init (longitude: String, latitude: String) {
            self.longitude = longitude
            self.latitude = latitude
        }
    }
    
    // MARK: - GeneralInfo
    public struct GeneralInfo{
        public let generalRule, childRule: String
        
        public init (generalRule: String, childRule: String) {
            self.generalRule = generalRule
            self.childRule = childRule
        }
    }
}
