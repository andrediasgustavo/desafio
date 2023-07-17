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
    
    func testGetFirstRow() {
        let tableView = self.homeVC.tableView
        let indexPath0 = IndexPath(item: 0, section: 0)
        tableView.reloadData()
        
        let firstCell = tableView.cellForRow(at: indexPath0)
        let visibleRows = tableView.indexPathsForVisibleRows
        XCTAssertNotNil(visibleRows)
        XCTAssert(tableView.indexPathsForVisibleRows!.contains(indexPath0))
        XCTAssertNotNil(firstCell)
    }
    
    func testNumbersOfComicsItems() {
        XCTAssertEqual(self.homeVC.comicsList.count, 3)
    }
    
    func testNumberOFRowsAtSectionZero() {
        XCTAssertEqual(self.homeVC.tableView.numberOfRows(inSection: 0), self.homeVC.comicsList.count)
    }
    
    func testErrorView() {
        let navigationController = UINavigationController()
        let apiService = MockMarvelAPIService(returnErrorResponse: true)
        let viewModel = HomeViewModel(apiService: apiService)
        self.homeVC = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([self.homeVC], animated: false)
        _ = self.homeVC.view
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(self.homeVC.errorView)
            XCTAssertEqual(self.homeVC.errorView?.isHidden, false)
        }
    }
    
}
