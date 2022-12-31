//
//  QueryRequest.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/31/22.
//

import Foundation

public struct QueryRequest: ExternalAPIRequest{
    
    public typealias Response = NewsResponse
    
    public var hostName: String { return "https://newsapi.org" }
    
    public var resourceName: String { return "v2/everything?\(self.query)\(self.language)\(self.from)\(self.to)\(self.searchIn)\(self.sources)\(self.domains)\(self.excludeDomains)\(self.sortBy)\(self.apiKey)" }
    
    public var apiKey: String  { return "apiKey=5b5a47c88e734c448bdbae91ae7389be" }
    
    public var query: String = ""
    public var language: String = ""
    public var from: String = ""
    public var to: String = ""
    public var searchIn: String = ""
    public var sources: String = ""
    public var domains: String = ""
    public var excludeDomains: String = ""
    public var sortBy: String = ""
    
    public init(query: String,
                language: Country? = nil,
                from: Date? = nil,
                to: Date? = nil,
                searchIn: Int? = nil,
                sources: [Source]? = nil,
                domains: String? = nil,
                excludeDomains: String? = nil,
                sortBy: String? = nil) {
        
        self.query = "q=" + query + "&"
        
        if let language = language {
            self.language = "language=" + language.language + "&"
        }
        
//        if let from = from {
//            self.from = "pageSize=\(pageSize)&"
//        }
//
//        if let pageNumber = pageNumber {
//            self.pageNumber = "page=\(pageNumber)&"
//        }
//
//        if let pageNumber = pageNumber {
//            self.pageNumber = "page=\(pageNumber)&"
//        }
        
    }
    
}
