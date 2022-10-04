//
//  EventRemoteDTO.swift
//  data
//
//  Created by Nazim Asadov on 30.08.22.
//

import Foundation
import domain

struct InitialEventsDTO: Decodable {
    let events: EventsDTO?
    let pagedLinks: PagedLinksDTO?
    let page: PageDTO?

    enum CodingKeys: String, CodingKey {
        case events = "_embedded"
        case pagedLinks = "_links"
        case page
    }
}

extension InitialEventsDTO {
    
    struct EventsDTO: Decodable {
        let events: [EventDTO]?
    }
    
    struct PagedLinksDTO: Decodable {
        let firstPage, selfPage, nextPage, lastPage: LinksDTO?

        enum CodingKeys: String, CodingKey {
            case firstPage = "first"
            case selfPage = "self"
            case nextPage = "next"
            case lastPage = "last"
        }
    }
    
    struct PageDTO: Decodable {
        let size, totalElements, totalPages, number: Int?
    }
}

extension InitialEventsDTO.PagedLinksDTO {
    struct LinksDTO: Decodable {
        let href: String?
    }
}

struct EventDTO: Decodable {
    let name, type, id: String?
    let url: String?
    let images: [ImageDTO]?
    let dates: DatesDTO?
    let classifications: [ClassificationDTO]?
    let info: String?
    let pleaseNote: String?
    let priceRanges: [PriceRangeDTO]?
    let seatmap: SeatmapDTO?
    let ticketLimit: TicketLimitDTO?
    let ageRestrictions: AgeRestrictionsDTO?
    let _embedded: EmbeddedDTO?
}

extension EventDTO {
    // MARK: - Image
    struct ImageDTO: Decodable {
        let ratio: String?  // "16_9", "3_2", "4_3"
        let url: String?
        let width, height: Int?
    }
    // MARK: - Dates
    struct DatesDTO: Decodable {
        let start: StartDTO?
        let status: StatusDTO?
    }
    
    // MARK: - Classification
    struct ClassificationDTO: Decodable {
        let segment, genre, subGenre: GenreDTO?
    }
    // MARK: - PriceRange
    struct PriceRangeDTO: Decodable {
        var currency: String?
        var min, max: Double?
    }
    
    // MARK: - Seatmap
    struct SeatmapDTO: Decodable {
        let staticUrl: String?
    }
    
    // MARK: - TicketLimit
    struct TicketLimitDTO: Decodable {
        let info: String?
    }
    
    // MARK: - AgeRestrictions
    struct AgeRestrictionsDTO: Decodable {
        let legalAgeEnforced: Bool?
    }
    
    // MARK: - Embedded
    struct EmbeddedDTO: Decodable {
        let venues: [VenueDTO]?
    }
}

extension EventDTO.ClassificationDTO {
    struct GenreDTO: Decodable {
        let name: String?
    }
}

extension EventDTO.DatesDTO {
    // MARK: - Start
    struct StartDTO: Decodable {
        let localDate, localTime: String?
        let dateTime: String?
    }

    // MARK: - Status
    struct StatusDTO: Decodable {
        let code: String?
    }
}

extension EventDTO.EmbeddedDTO {
    // MARK: - Venue
    struct VenueDTO: Decodable {
        let name, type, id: String?
        let url: String?
        let locale: String?
        let images: [EventDTO.ImageDTO]?
        let city: CityDTO?
        let state: StateDTO?
        let country: CountryDTO?
        let address: AddressDTO?
        let location: LocationDTO?
        let parkingDetail, accessibleSeatingDetail: String?
        let generalInfo: GeneralInfoDTO?
    }
}

extension EventDTO.EmbeddedDTO.VenueDTO {
    
    // MARK: - City
    struct CityDTO: Decodable {
        let name: String?
    }
    
    // MARK: - State
    struct StateDTO: Decodable {
        let name, stateCode: String?
    }

    // MARK: - Country
    struct CountryDTO: Decodable {
        let name, countryCode: String?
    }
    
    // MARK: - Address
    struct AddressDTO: Decodable {
        let line1: String?
    }

    // MARK: - GeneralInfo
    struct GeneralInfoDTO: Decodable {
        let generalRule, childRule: String?
    }

    // MARK: - Location
    struct LocationDTO: Decodable {
        let longitude, latitude: String?
    }
}
