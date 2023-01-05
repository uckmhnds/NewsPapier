//
//  Content.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/17/22.
//

import Foundation
import UIKit

public struct Country {
    
    let name: String
    let code: String
    let flag: String
    let language: String
    
}

public struct Countries {
    
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

public struct Preferences{
    
    static let country: Country = Country(name: "United States", code: "us", flag: "🇺🇸", language: "en")
    static let pageSize: Int = 10
    static let pageNumber: Int = 1
    
    static let shortText: String = "This is the title of news"
    static let midText: String = "This is the title of news. This title should be wrapped by layout settings"
    static let longText: String = "This is the title of news. This title should be wrapped by layout settings. This is the title of news. This title should be wrapped by layout settings. This is the title of news. This title should be wrapped by layout settings"
    
    static let scrollDownRefreshTime: Double = 1.2
    
    static let sideMenuWidthRation: Double = 0.4
    
    static let sideMenuDidShowDuration: TimeInterval = 0.25
    static let sideMenuDidShowDelay: TimeInterval = 0.0
    static let sideMenuDidShowDamping: CGFloat = 0.8
    static let sideMenuDidShowVelocity: CGFloat = 0.0
    static let sideMenuDidShowOption: UIView.AnimationOptions = .curveEaseIn
    
    static let sideMenuDidDisappearDuration: TimeInterval = 0.5
    static let sideMenuDidDisappearDelay: TimeInterval = 0.0
    static let sideMenuDidDisappearDamping: CGFloat = 0.8
    static let sideMenuDidDisappearVelocity: CGFloat = 0.0
    static let sideMenuDidDisappearOption: UIView.AnimationOptions = .curveEaseIn
    
    static let viewAlphaOne: CGFloat = 1.0
    static let viewAlphaTwo: CGFloat = 0.8
    static let viewAlphaThree: CGFloat = 0.6
    
    //
    // Compositional Layout
    //
    
    static let primaryContentInset: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 24, trailing: 0)
    static let primaryItemPadding: CGFloat = 5
    static let primaryItemWidthFraction: CGFloat = 1
    static let primaryItemHeightFraction: CGFloat = 1
    static let primaryGroupWidthFraction: CGFloat = 0.25
    static let primaryGroupHeightFraction: CGFloat = 0.14
    
    static let secondaryContentInset: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
    static let secondaryItemPadding: CGFloat = 5
    static let secondaryItemWidthFraction: CGFloat = 1
    static let secondaryItemHeightFraction: CGFloat = 1
    static let secondaryGroupWidthFraction: CGFloat = 0.4
    static let secondaryGroupHeightFraction: CGFloat = 0.08
    
    static let tertiaryContentInset: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
    static let tertiaryItemPadding: CGFloat = 5
    static let tertiaryItemWidthFraction: CGFloat = 1
    static let tertiaryItemHeightFraction: CGFloat = 1
    static let tertiaryGroupWidthFraction: CGFloat = 1
    static let tertiaryGroupHeightFraction: CGFloat = 0.28
    
    static let headerItemFractionalWidth: CGFloat = 1.0
    static let headerItemHeight: CGFloat = 44.0
    static let headerItemOffsetX: CGFloat = 0.0
    static let headerItemOffsetY: CGFloat = 0.0
    
    static let footerItemFractionalWidth: CGFloat = 1.0
    static let footerItemHeight: CGFloat = 20.0
    
    static let headerTitleLeadingPadding: CGFloat = 13
    static let headerTitleCenterYPadding: CGFloat = 5
    static let headerImageTrailingPadding: CGFloat = 13
    
    static let footerPageControlPadding: CGFloat = 10
    
    static let backgroundCornerRadius: CGFloat = 0
    static let backgroundHorizontalPadding: CGFloat = 0
    static let backgroundVerticalPadding: CGFloat = 5
    
    static let topNewsImageSize: CGFloat = 72
    static let topNewsImageCornerRadius: CGFloat = 8
    static let topNewsCellPadding: CGFloat = 10
    
    static let discoverMainCornerRadius: CGFloat = 5
    static let discoverMainPadding: CGFloat = 5
    
    static let discoverSourcesCornerRadius: CGFloat = 8
    
    static let discoverCategoryCornerRadius: CGFloat = 8
    static let discoverCategoryPadding: CGFloat = 10
}

public enum Category: String, CaseIterable{
    
    case categories
    case sources
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    var name: String { return self.rawValue}
    
}


public enum SearchIn: String, CaseIterable{
    case title, description, content
    
    var name: String { return self.rawValue}
}

public enum SortBy: String, CaseIterable{
    case relevancy, popularity, publishedAt
    
    var name: String { return self.rawValue}
}

public enum Language: String, CaseIterable{
    case en
    
    var name: String { return self.rawValue}
}

enum SideMenuState {
    case opened
    case closed
}
