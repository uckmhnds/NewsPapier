//
//  LocalRequest.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/3/23.
//

import Foundation

public protocol LocalRequest: Encodable {
    
    associatedtype Response: Decodable
//    var hostName: String { get }
//    var resourceName: String { get }
    
}

public struct NewsLocalRequest: LocalRequest{
    
    public typealias Response = NewsResponse
    
    public var pageSize: String = ""
    public var pageNumber: String = ""
    
    public init(pageSize: Int? = nil,
                pageNumber: Int? = nil) {
        
        if let pageSize = pageSize {
            self.pageSize = "pageSize=\(pageSize)&"
        }
        
        if let pageNumber = pageNumber {
            self.pageNumber = "page=\(pageNumber)&"
        }
        
    }
    
}
