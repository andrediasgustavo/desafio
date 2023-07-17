//
//  HomeViewModelTests.swift
//  desafioTests
//
//  Created by Andre Dias on 16/07/23.
//

import XCTest
import Combine

@testable import desafio

class HomeViewModelTests: XCTestCase {
    
    var homeViewModel: HomeViewModel!
    var mockAPIService: MarvelAPIServiceInterface!
    private var subscriptions = Set<AnyCancellable>()
    
    override func setUp() {
        self.mockAPIService = MockMarvelAPIService()
        self.homeViewModel = .init(apiService: self.mockAPIService)
        
        self.homeViewModel.inputs.fetchMarvelComicsData()
    }
    
    override func tearDown() {
        self.homeViewModel = nil
        self.mockAPIService = nil
    }
    
    func testLoadComicsListMockedAPICallReturnsSuccesfully() throws {
        let comicsList = try awaitPublisher(homeViewModel.comicsList)
        XCTAssertEqual(comicsList.count, 3)
    }

    func testComicsListIsNotEmpty() throws {
        let comicsList = try awaitPublisher(homeViewModel.comicsList)
        XCTAssertFalse(comicsList.isEmpty)
    }

    func testErrorAfterSuccessfulComicsLoad() throws {
        let error = try awaitPublisher(homeViewModel.error)
        XCTAssertNil(error)
    }
    
    func testComicsListAfterAPICallWithError() throws {
        let mockAPIService = MockMarvelAPIService(returnErrorResponse: true)
        self.homeViewModel = .init(apiService: mockAPIService)
        homeViewModel.inputs.fetchMarvelComicsData()
        let comicsList = try awaitPublisher(homeViewModel.comicsList)
        XCTAssertTrue(comicsList.isEmpty)
    }
    
    func testLoadComicsListMockedAPICallReturnsWithError() throws {
        let mockAPIService = MockMarvelAPIService(returnErrorResponse: true)
        self.homeViewModel = .init(apiService: mockAPIService)
        homeViewModel.inputs.fetchMarvelComicsData()
        let comicsList = try awaitPublisher(homeViewModel.comicsList)
        let error = try awaitPublisher(homeViewModel.error)
        XCTAssertEqual(comicsList.count, 0)
        XCTAssertNotNil(error)
    }
    
    func testErrorAfterAPICallWithError() throws {
        let mockAPIService = MockMarvelAPIService(returnErrorResponse: true)
        self.homeViewModel = .init(apiService: mockAPIService)
        homeViewModel.inputs.fetchMarvelComicsData()
        let error = try awaitPublisher(homeViewModel.error)
        XCTAssertEqual(error, NetworkError.decodeError.description)
    }
    
    
    
}
