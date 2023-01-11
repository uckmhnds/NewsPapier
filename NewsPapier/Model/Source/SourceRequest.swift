//
//  SourceRequest.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/31/22.
//

import Foundation

public struct SourcesRequest: ExternalAPIRequest {
    
    public typealias Response = SourceResponse
    
    public var hostName: String { return "https://newsapi.org" }
    public var resourceName: String { return "v2/top-headlines/sources?\(self.category)\(self.country)\(self.language)\(self.pageSize)\(self.pageNumber)\(self.apiKey)" }

//    // Parameters
    public var category: String = ""
    public var country: String = ""
    public var language: String = ""
    public var pageSize: String = ""
    public var pageNumber: String = ""
    public var apiKey: String = "apiKey=5b5a47c88e734c448bdbae91ae7389be"
    
    public init(categoryCase: CategoryCase? = nil,
                countryCase: CountryCase? = nil,
                language: Language? = nil,
                pageSize: Int? = nil,
                pageNumber: Int? = nil) {

        if let categoryCase = categoryCase {
            self.category = "category=" + categoryCase.rawValue + "&"
        }

        if let countryCase = countryCase {
            self.country = "country=" + countryCase.code + "&"
        }
        
        if let language = language {
            self.language = "language=" + language.rawValue + "&"
        }
        
        if let pageSize = pageSize {
            self.pageSize = "pageSize=\(pageSize)&"
        }
        
        if let pageNumber = pageNumber {
            self.pageNumber = "page=\(pageNumber)&"
        }
        
    }
}
