//
//  UseCaseTests.swift
//  UseCaseTests
//
//  Created by Nazim Asadov on 04.10.22.
//

import XCTest
import Promises
import RxSwift
@testable import domain

final class UseCaseTests: XCTestCase {
    
    var mockData: EventRepoMockData?
    
    var compositeDisposable: CompositeDisposable?
    
    let expectedData = InitialEvents.init(events: InitialEvents.Events.init(events: [EventResponse.init(name: "Weeknd", type: "music", id: "test1234", url: "test@gmail.com", images: [EventResponse.Image.init(ratio: "16_9", url: "testurl.com", width: 500, height: 200)], dates: EventResponse.Dates.init(start: EventResponse.Dates.Start.init(localDate: "12.12.2022", localTime: "19:00", dateTime: "22:00"), status: EventResponse.Dates.Status.init(code: "1234")), classifications: [EventResponse.Classification.init(segment: EventResponse.Classification.Genre(name: "concert"), genre: EventResponse.Classification.Genre(name: "music"), subGenre: EventResponse.Classification.Genre(name: "hiphop"))], info: "TestInfo", pleaseNote: "TestNote", priceRanges: [EventResponse.PriceRange(currency: "USD", min: 25.0, max: 2500.0)], seatmap: EventResponse.Seatmap.init(staticUrl: "TestSeatmap.com"), ticketLimit: EventResponse.TicketLimit.init(info: "TestTicketInfo"), ageRestriction: EventResponse.AgeRestrictions.init(legalAgeEnforced: false), _embedded: EventResponse.Embedded.init(venues: [EventResponse.Embedded.Venue.init(name: "TestVenue", type: "music", id: "Test1234", url: "weeknd.com", locale: "en", images: [EventResponse.Image.init(ratio: "4_3", url: "weeknd.com", width: 500, height: 300)], city: EventResponse.Embedded.Venue.City.init(name: "LA"), state: EventResponse.Embedded.Venue.State.init(name: "Miami", stateCode: "Test5300"), country: EventResponse.Embedded.Venue.Country.init(name: "USA", countryCode: "1"), address: EventResponse.Embedded.Venue.Address.init(line1: "Test12345"), location: EventResponse.Embedded.Venue.Location.init(longitude: "36.6", latitude: "46.1"), parkingDetail: "No any detail", accessibleSeatingDetail: "Not", generalInfo: EventResponse.Embedded.Venue.GeneralInfo.init(generalRule: "Be joyful", childRule: "6 ages and over"))]))]), pagedLinks: InitialEvents.PagedLinks.init(firstPage: InitialEvents.PagedLinks.Links.init(href: "test@gmail.com"), selfPage: InitialEvents.PagedLinks.Links.init(href: "test1@gmail.com"), nextPage: InitialEvents.PagedLinks.Links.init(href: "test2@gmail.com"), lastPage: InitialEvents.PagedLinks.Links.init(href: "test3@gmail.com")), page: InitialEvents.Page.init(size: 20, totalElements: 400, totalPages: 20, number: 4))

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockData = EventRepoMockData()
        compositeDisposable = CompositeDisposable()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        compositeDisposable?.dispose()
        mockData = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetClassificationEventsUseCase() {
        let useCase = GetClassificationEventsUseCase(repo: mockData!)
        let inputData = "TestId"
        var returnedData: InitialEvents?
        
        mockData?.getInitialEvent.fulfill(expectedData)
        
        let promise = XCTestExpectation(description: "Should return a value")
        
        useCase.execute(name: inputData).then({ initialEvents in
            returnedData = initialEvents
            promise.fulfill()
        }).catch({ err in
            XCTFail(err.localizedDescription)
        })
        
        wait(for: [promise], timeout: 2.0)
        
        XCTAssertNotNil(returnedData)
        XCTAssertEqual(expectedData, returnedData)
    }
    
    func testGetSearchedEvents() {
        let useCase = GetSearchedEventsUseCase(repo: mockData!)
        let inputData = "concert"
        var returnedData: InitialEvents?
        
        mockData?.getInitialEvent.fulfill(expectedData)
        
        let promise = XCTestExpectation(description: "Should return a value")
        
        useCase.execute(text: inputData).then({ initialEvents in
            returnedData = initialEvents
            promise.fulfill()
        }).catch({ err in
            XCTFail(err.localizedDescription)
        })
        
        wait(for: [promise], timeout: 2.0)
        
        XCTAssertNotNil(returnedData)
        XCTAssertEqual(expectedData, returnedData)
    }
    
    func testGetPagedEvents() {
        let useCase = GetPagedEventsUseCase(repo: mockData!)
        let inputData1 = "TestId"
        let inputData2 = 7
        var returnedData: InitialEvents?
        
        mockData?.getInitialEvent.fulfill(expectedData)
        
        let promise = XCTestExpectation(description: "Should return a value")
        
        useCase.execute(name: inputData1, page: inputData2).then({ initialEvents in
            returnedData = initialEvents
            promise.fulfill()
        }).catch({ err in
            XCTFail(err.localizedDescription)
        })
        
        wait(for: [promise], timeout: 2.0)
        
        XCTAssertNotNil(returnedData)
        XCTAssertEqual(expectedData, returnedData)
    }
    
    func testGetEventUseCase() {
        let useCase = GetEventWithIdUseCase(repo: self.mockData!)
        
        let inputData = "TestId"
        var returnedData: EventResponse?

        mockData?.getEvent.fulfill(expectedData.events.events.first!)
        
        let promise = XCTestExpectation(description: "Should return a value")
        
        useCase.execute(id: inputData).then ({ eventResponse in
            returnedData = eventResponse
            promise.fulfill()
        }).catch({ err in
            XCTFail(err.localizedDescription)
        })
        
        wait(for: [promise], timeout: 2.0)
        
        XCTAssertNotNil(returnedData)
        XCTAssertEqual(expectedData.events.events.first, returnedData)
    }
    
    func testSyncEventsUseCase() {
        let useCase = SyncEventUseCase(repo: self.mockData!)

        let expectedSyncData = Data()
        var returnedData = Data()

//        let promise = XCTestExpectation(description: "Should return a value")

        mockData?.syncEvent = Promise<Data>.pending()
        mockData?.syncEvent.fulfill(expectedSyncData)
        useCase.execute().then { data in
            returnedData = data
//            promise.fulfill()
        }.catch({ err in
            XCTFail(err.localizedDescription)
        })

//        wait(for: [promise], timeout: 1.0)

        XCTAssertEqual(expectedSyncData, returnedData)
    }
    
    func testObserveEventUseCase() {
        let useCase = ObserveEventUseCase.init(repo: mockData!)
        
        var returnedData: InitialEvents?
        
        
        let promise = XCTestExpectation(description: "Should return a value")
        let subscription = useCase.execute().subscribe { initialEvents in
            guard let value = initialEvents.element else {return}
            
            returnedData = value
            promise.fulfill()
        }
        
        mockData?.observeEventValue.onNext(expectedData)

        let _ = compositeDisposable?.insert(subscription)
        
        wait(for: [promise], timeout: 5.0)
        
        XCTAssertNotNil(returnedData)
        XCTAssertEqual(expectedData, returnedData)
    }

}
