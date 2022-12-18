//
//  Content.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/17/22.
//

import Foundation


struct Country {
    
    let name: String
    let code: String
    let flag: String
    let language: String
    
}


struct Countries {
    
    static let list: [Country] = [Country(name: "United States", code: "us", flag: "🇺🇸", language: "en"),
                                   Country(name: "Germany", code: "de", flag: "🇩🇪", language: "de"),
                                   Country(name: "France", code: "fr", flag: "🇫🇷", language: "fr"),
                                   Country(name: "Great Britain", code: "gb", flag: "🇬🇧", language: "en"),
                                   Country(name: "Italy", code: "it", flag: "🇮🇹", language: "it"),
                                   Country(name: "Holland", code: "nl", flag: "🇳🇱", language: "nl")]
    
}

struct TestCategory{
    
    let name: String
    let symbol: String
    let symbolHighlighted: String
    let code: String
    
}

struct TestCategories {
    
    static let list: [TestCategory] = [TestCategory(name: "General",
                                                    symbol: "globe.europe.africa",
                                                    symbolHighlighted: "globe.europe.africa.fill",
                                                    code: "general"),
                                       
                                       TestCategory(name: "Business",
                                                    symbol: "latch.2.case",
                                                    symbolHighlighted: "latch.2.case.fill",
                                                    code: "business"),
                                       
                                       TestCategory(name: "Science",
                                                    symbol: "graduationcap",
                                                    symbolHighlighted: "graduationcap.fill",
                                                    code: "science"),
                                       
                                       TestCategory(name: "Technology",
                                                    symbol: "av.remote",
                                                    symbolHighlighted: "av.remote.fill",
                                                    code: "technology"),
                                       
                                       TestCategory(name: "Sports",
                                                    symbol: "cricket.ball",
                                                    symbolHighlighted: "cricket.ball.fill",
                                                    code: "sports"),
                                       
                                       TestCategory(name: "Health",
                                                    symbol: "cross.case",
                                                    symbolHighlighted: "cross.case.fill",
                                                    code: "health"),
                                       
                                       TestCategory(name: "Entertainment",
                                                    symbol: "shower",
                                                    symbolHighlighted: "shower.fill",
                                                    code: "Entertainment")]
    
}
