//
//  AssignmentsTests.swift
//  AssignmentsTests
//
//  Created by Al-Amin on 2023/02/14.
//

import XCTest
import Combine
@testable import Assignments

final class AssignmentsTests: XCTestCase {
    
    var sut: ViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    override func setUp() {
        sut = ViewModel()
    }
    
    override func tearDown() {
        sut = nil
        subscriptions.removeAll()
    }
    
    func test_whenSearchTextIsEmpty_shouldNotCallAPI() {
        // Given
        let expectation = XCTestExpectation(description: "should not call API when searchText is empty")
        let expectedCount = 0
        
        sut.repositoryList = []
        sut.$repositoryList.sink { count in
            // Then
            XCTAssertEqual(count.count, expectedCount)
            expectation.fulfill()
        }.store(in: &subscriptions)
        
        // When
        sut.searchText = ""
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_whenSearchTextIsValid_shouldFetchData() {
        let expectation = XCTestExpectation(description: "should fetch data")
        let expectedCount = 0
        
        sut.$repositoryList.dropFirst().sink { count in
            XCTAssert(count.count > expectedCount)
            expectation.fulfill()
        }.store(in: &subscriptions)
        
        sut.searchText = "swift"
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_whenAPIFails_shouldReturnError() {
        let expectation = XCTestExpectation(description: "should return error when API fails")
        
        sut.$error.dropFirst().sink { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }.store(in: &subscriptions)
        
        sut.fetchData(searchText: "  ")
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_whenAPIReturnsNoData_shouldReturnEmptyRepositoryList() {
        let expectation = XCTestExpectation(description: "should return empty repository list when API returns no data")
        let expectedCount = 0
        
        sut.$repositoryList.dropFirst().sink { data in
            XCTAssertEqual(data.count, expectedCount)
            expectation.fulfill()
        }.store(in: &subscriptions)
        
        sut.fetchData(searchText: "random_text")
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_whenAPIReturnsData_shouldReturnNonEmptyRepositoryList() {
        let expectation = XCTestExpectation(description: "should return non-empty repository list when API returns data")
        sut.fetchData(searchText: "Q")
        sut.$repositoryList.dropFirst().sink { data in
            
            XCTAssertNotNil(data)
            expectation.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 15)
    }
    
    func test_RepositoryList_InitialValue() {
        XCTAssertTrue(sut.repositoryList.isEmpty)
    }
    
    func test_SearchText_InitialValue() {
        XCTAssertEqual(sut.searchText, "")
    }
    
    func test_Error_InitialValue() {
        XCTAssertNil(sut.error)
    }
    
    func test_IsLoading_InitialValue() {
        XCTAssertFalse(sut.isLoading)
    }
    
    func test_NoResultFound() {
        let expectation = XCTestExpectation(description: "Invalid URL")
        
        sut.fetchData(searchText: "///")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.sut.repositoryList.isEmpty)
            XCTAssertNil(self.sut.error)
            XCTAssertFalse(self.sut.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
}
