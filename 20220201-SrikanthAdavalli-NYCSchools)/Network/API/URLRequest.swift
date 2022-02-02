//
//  URLRequest.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import Foundation

protocol Request {
    init(
        endpoint: EndPoint,
        httpMethod: HTTPMethod,
        cachePolicy: URLRequest.CachePolicy,
        timeoutInterval: TimeInterval
    )
}

@available(macOS 11.0, *)
extension URLRequest: Request {
    init(
        endpoint: EndPoint,
        httpMethod: HTTPMethod = .get,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        timeoutInterval: TimeInterval = .infinity
    ) {
        guard let url = endpoint.path else {
            preconditionFailure("Invalid URL used to create URL instance")
        }
        
        self.init(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        self.httpMethod = httpMethod.rawValue
    }
}
