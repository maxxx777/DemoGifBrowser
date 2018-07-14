//
//  NetworkingTests.swift
//  DemoGifBrowserTests
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import XCTest
@testable import DemoGifBrowser

class NetworkingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNetworkingGetItemsCorrectly() {
        
        //Given
        let testItem = TestItem(itemId: "test_id", name: "test_name")
        let successData = SuccessResult<[TestItem]>(data: [testItem])
        let encodedData = try? JSONEncoder().encode(successData)
        
        let providerMock = URLSessionMock()
        providerMock.data = encodedData
        
        let networking = Networking<[TestItem]>(provider: providerMock)
        
        //When
        networking.getItems(with: "test_url_string") { (result, _) in
            //Then
            XCTAssertEqual(result?.data.last!, testItem, "items should be equal")
        }
    }
    
    func testNetworkingDoesNotGetItemsBecauseOfError() {
        
        //Given
        let providerMock = URLSessionMock()
        providerMock.error = TestError()
        
        let networking = Networking<TestItem>(provider: providerMock)
        
        //When
        networking.getItems(with: "test_url_string") { (_, error) in
            //Then
            XCTAssertEqual(error!.localizedDescription, TestError().localizedDescription, "error description should be correct")
        }
    }
}

struct TestItem: Codable {
    
    let itemId: String
    let name: String
}

extension TestItem: Equatable {
    static func == (lhs: TestItem, rhs: TestItem) -> Bool {
        return lhs.itemId == rhs.itemId &&
            lhs.name == rhs.name
    }
}

struct TestError: LocalizedError {
    
    var errorDescription: String? {
        return "test_error"
    }
}

class URLSessionMock: URLSession {
    
    var data: Data?
    var error: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let data = self.data
        let error = self.error
        
        return URLSessionDataTaskMock(completion: {
            completionHandler(data, nil, error)
        })
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    
    private let completion: () -> ()
    
    init(completion: @escaping () -> ()) {
        self.completion = completion
    }
    
    override func resume() {
        completion()
    }
}

