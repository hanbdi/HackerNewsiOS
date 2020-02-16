//
//  URLSessionMock.swift
//  HackerNewsiOSTests
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation
@testable import HackerNewsiOS

class URLSessionMock: URLSessionProtocol {
    var requestCalled: URLRequest!
    var completion: DataTaskResult!
    
    func dataTask(with: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        self.requestCalled = with
        self.completion = completionHandler
        
        return URLSessionDataTaskMock()
    }
    
}

class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    var resumeCalled: Int = 0
    
    func resume() {
        resumeCalled += 1
    }
}

