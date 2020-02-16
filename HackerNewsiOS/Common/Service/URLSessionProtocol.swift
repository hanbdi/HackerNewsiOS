//
//  URLSessionProtocol.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol {
    func dataTask(with: URLRequest, completionHandler: @escaping DataTaskResult)
        -> URLSessionDataTaskProtocol
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }

// MARK: conform to URLSessionProtocol for testable

extension URLSession: URLSessionProtocol {
    
    func dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return (dataTask(with: with, completionHandler: completionHandler)
        as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
    
}

extension URLResponse {
    var isSuccess: Bool {
        guard let httpResponse = self as? HTTPURLResponse else {
            return false
        }
        
        return httpResponse.statusCode >= 200 && httpResponse.statusCode < 300
    }
    
    var httpStatusCode: Int {
        return ((self as? HTTPURLResponse)?.statusCode).or(0)
    }
}
