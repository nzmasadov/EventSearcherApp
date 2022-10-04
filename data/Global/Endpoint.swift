//
//  Endpoint.swift
//  data
//
//  Created by Nazim Asadov on 03.09.22.
//

import Foundation

struct API {
    static let baseUrl = "https://app.ticketmaster.com/discovery/v2/"
    static let apiKey = "apikey=7EywVn2BCqtjA1NcEQNzrNxOKg8ICWXX#"
}

fileprivate enum App: String {
    case event = "events/"
    case classification = "/events.json?classificationName="
    case classificationPaged = "events.json?classificationName"
    case search = "events.json?keyword="

}

enum Endpoint {
    case event(id:String)
    case classification(name: String)
    case classificationPaged(name: String, page: Int)
    case search(text: String)
        
    var path: String {
        switch self {
        case .event(let id):
            return request(app: .event, params: "\(id).json?")
        case .classification(let name):
            return request(app: .classification, params: "\(name)&")
        case .classificationPaged(let name, let page):
            return request(app: .classificationPaged, params: "=\(name)&page=\(page)&")
        case .search(let text):
            return request(app: .search, params: "\(text.lowercased())&")
        }
    }
    
    private func request(app: App, params: String) -> String {
        return API.baseUrl + app.rawValue + params + API.apiKey
    }
}

extension Optional where Wrapped == String {
    func isEmptyOrNil() -> Bool {
        return self == nil || self?.isEmpty == true
    }
    
    func orEmpty() -> String {
        return self ?? ""
    }
}
