//
//  GiphyServiceTests.swift
//  DemoGifBrowserTests
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import XCTest
@testable import DemoGifBrowser

class GiphyServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGiphyServiceFetchesItemsCorrectly() {
        
        //Given
        let imageItem = ImageItem(url: "original_image_url", width: 100, height: 100)
        let imagesItem = ImagesItem(original: imageItem, preview: imageItem)
        let testItem = GifItem(itemId: "item_id", imagesItem: imagesItem)
        let successData = SuccessResult<[GifItem]>(data: [testItem])
        
        let encodedData = try? JSONEncoder().encode(successData)
        
        let providerMock = URLSessionMock()
        providerMock.data = encodedData
        
        let networking = Networking<[GifItem]>(provider: providerMock)
        let service = GiphyServiceImp.init(networking: networking)
        
        //When
        service.fetchGifItems { (items, _) in
            //Then
            XCTAssertEqual(items.last!, testItem, "items should be equal")
        }
    }
    
    func testGiphyServiceDoesNotFetchItemsBecauseOfError() {
        
        //Given        
        let providerMock = URLSessionMock()
        providerMock.error = TestError()
        
        let networking = Networking<[GifItem]>(provider: providerMock)        
        let service = GiphyServiceImp.init(networking: networking)
        
        //When
        service.fetchGifItems { (_, error) in
            //Then
            XCTAssertEqual(error!.localizedDescription, TestError().localizedDescription, "error description should be correct")
        }        
    }
}
