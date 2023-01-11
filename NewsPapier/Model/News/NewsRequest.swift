//
//  NewsRequest.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/31/22.
//

import Foundation

public struct NewsRequest: ExternalAPIRequest{
    
    public typealias Response = NewsResponse
    
    public var hostName: String { return "https://newsapi.org" }
    
    public var resourceName: String { return "v2/top-headlines?\(self.category)\(self.country)\(self.pageSize)\(self.pageNumber)\(self.apiKey)" }
    
    public var apiKey: String  { return "apiKey=5b5a47c88e734c448bdbae91ae7389be" }
    
    public var category: String = ""
    public var country: String = ""
    public var pageSize: String = ""
    public var pageNumber: String = ""
    
    public init(category: CategoryCase? = nil,
                country: CountryCase? = nil,
                pageSize: Int? = nil,
                pageNumber: Int? = nil) {

        if let category = category {
            self.category = "category=" + category.rawValue + "&"
        }

        if let country = country {
            self.country = "country=" + country.code + "&"
        }
        
        if let pageSize = pageSize {
            self.pageSize = "pageSize=\(pageSize)&"
        }
        
        if let pageNumber = pageNumber {
            self.pageNumber = "page=\(pageNumber)&"
        }
        
    }
    
}
