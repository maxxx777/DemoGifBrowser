//
//  NetworkingMock.swift
//  DemoGifBrowserTests
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import Foundation

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
