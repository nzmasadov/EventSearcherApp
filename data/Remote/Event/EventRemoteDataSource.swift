//
//  EventRemoteDataSource.swift
//  data
//
//  Created by Nazim Asadov on 30.08.22.
//

import Foundation
import Alamofire
import Promises

class EventRemoteDataSource: EventRemoteDataSourceProtocol {
           
    let networkProvider: Session
    
    init(networkProvider: Session) {
        self.networkProvider = networkProvider
    }
    
    func getEventsWith(id: String) -> Promise<EventDTO> {
        let promise = Promise<EventDTO>.pending()
        let url = Endpoint.event(id: id).path
        
        networkProvider.request(url, method: .get).responseDecodable(of: EventDTO.self) { response in
            
            if let error = response.error {
                print(error)
                return promise.reject(error)
            }
            
            switch response.result {
            case .failure(let error):
                promise.reject(error)
            case .success(let event):
                promise.fulfill(event)
            }
        }
        return promise
    }
    
    
    func getClassifications(with name: String) -> Promise<InitialEventsDTO> {
        let promise = Promise<InitialEventsDTO>.pending()
        let url = Endpoint.classification(name: name).path
        print("nzm classificaiton url-> \(url)")
        
        
        networkProvider.request(url, method: .get).responseDecodable(of: InitialEventsDTO.self) { response in
            
            if let error = response.error {
                return promise.reject(error)
            }
            
            switch response.result {
            case .failure(let error):
                promise.reject(error)
            case .success(let event):
                promise.fulfill(event)
            }
        }
        return promise
    }
    
    
    func getSearchedEvents(with text: String) -> Promise<InitialEventsDTO> {
        let promise = Promise<InitialEventsDTO>.pending()
        let url = Endpoint.search(text: text).path
        print("nzm searched url-> \(url)")
        
        networkProvider.request(url, method: .get).responseDecodable(of: InitialEventsDTO.self) { response in
            
            if let error = response.error {
                return promise.reject(error)
            }
            
            switch response.result {
            case .failure(let error):
                promise.reject(error)
            case .success(let event):
                
                promise.fulfill(event)
            }
        }
        return promise
    }
    
    func getPagedEvents(with name: String, page: Int) -> Promise<InitialEventsDTO> {
        let promise = Promise<InitialEventsDTO>.pending()
        let url = Endpoint.classificationPaged(name: name, page: page).path
        
        networkProvider.request(url, method: .get).responseDecodable(of: InitialEventsDTO.self) { response in
            if let error = response.error {
                return promise.reject(error)
            }
            
            switch response.result {
            case .failure(let error):
                promise.reject(error)
            case .success(let event):
                promise.fulfill(event)
            }
        }
        return promise
    }
}
