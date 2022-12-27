//
//  News.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 30.09.2022.
//

import Foundation

#warning("Map this news to a newsModelView which reflects represenable object")
#warning("i.e. 3 hours, 1 day, 2 month etc. in timeView")

public struct News: Codable, Hashable{
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

public struct NewsResponse: Codable, Hashable{
    let articles: [News]?
    let status: String?
    let code: String?
    let message: String?
}

public struct NewsRequest: ExternalAPIRequest{
    
    public typealias Response = NewsResponse
    
    public var hostName: String { return "https://newsapi.org" }
    
    public var resourceName: String { return "v2/top-headlines?\(self.category)\(self.country)\(self.pageSize)\(self.pageNumber)\(self.apiKey)" }
    
    public var apiKey: String  { return "apiKey=5b5a47c88e734c448bdbae91ae7389be" }
    
    public var category: String = ""
    public var country: String = ""
    public var pageSize: String = ""
    public var pageNumber: String = ""
    
    public init(category: Category? = nil,
                country: Country? = nil,
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

public struct Source: Codable, Hashable{
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
}

public struct SourceResponse: Codable, Hashable{
    let sources: [Source]
}

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
    
    public init(category: Category? = nil,
                country: Country? = nil,
                language: Language? = nil,
                pageSize: Int? = nil,
                pageNumber: Int? = nil) {

        if let category = category {
            self.category = "category=" + category.rawValue + "&"
        }

        if let country = country {
            self.country = "country=" + country.code + "&"
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
