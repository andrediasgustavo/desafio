//
//  HomeViewControllerTests.swift
//  desafioTests
//
//  Created by Andre Dias on 16/07/23.
//

import XCTest

@testable import desafio

class HomeViewControllerTests: XCTestCase {
    private var homeVC: HomeViewController!
    
    override func setUp() {
        super.setUp()
        
        let navigationController = UINavigationController()
        let apiService = MockMarvelAPIService()
        let viewModel = HomeViewModel(apiService: apiService)
        self.homeVC = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([self.homeVC], animated: false)
        _ = self.homeVC.view
    }
    
    override func tearDown() {
        super.tearDown()
        self.homeVC = nil
    }
    
    func test_GetFirstRow() {
        let tableView = self.homeVC.tableView
        let indexPath0 = IndexPath(item: 0, section: 0)
        tableView.reloadData()
        
        let firstCell = tableView.cellForRow(at: indexPath0)
        let visibleRows = tableView.indexPathsForVisibleRows
        XCTAssertNotNil(visibleRows)
        XCTAssert(tableView.indexPathsForVisibleRows!.contains(indexPath0))
        XCTAssertNotNil(firstCell)
    }
    
    func test_NumbersOfComicsItems() {
        XCTAssertEqual(self.homeVC.comicsList.count, 3)
    }
    
    func test_NumberOFRowsAtSectionZero() {
        XCTAssertEqual(self.homeVC.tableView.numberOfRows(inSection: 0), self.homeVC.comicsList.count)
    }
    
}
