//
//  HomeModel.swift
//  presentation
//
//  Created by Nazim Asadov on 11.09.22.
//

import Foundation
import UIKit

public struct EventsType {
    var type: EventCategories
    public enum EventCategories: String {
        case categories = "Categories"
        case suggested = "Suggested for you"
        case concert = "Concerts"
        case sport = "Sport"
        case tourism = "Tourism"
        case performance = "Performance"
    }
}

struct ProfileData {
    var name: String?
    var image: UIImage?
    var price: String?
    var saveIcon: UIImage?
    var startDate: String?
    var place: String?
}

public struct Categories {
    var name: CategoryType
    var image: UIImage
    
    public enum CategoryType: String {
        case concert = "Concert"
        case sport = "Sport"
        case arts = "Arts & Theatre"
        case film = "Film"
        case music = "Music"
        case undefined = "Undefined"
        case tourism = "Venue Based"
        case upsell = "Upsell"
        case nonticket = "Nonticket"
        case performance = "Performance"
    }
}
