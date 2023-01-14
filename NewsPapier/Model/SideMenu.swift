//
//  SideMenu.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/14/23.
//

import Foundation

protocol SideMenuBaseSection{
    
    associatedtype SectionType
    
    var type: SideMenuSectionType {get}
    var name: String { get }
    var isOpened: Bool { get set }
    var items: [SectionType] { get set }
    var size: Int {get set}
    var viewedSize: Int {get}
    
    func toggle() -> Void
    
}

class SideMenuCategorySection: SideMenuBaseSection{
    
    typealias SectionType = CategoryCase
    
    let type: SideMenuSectionType
    var name: String
    var isOpened: Bool
    var items: [CategoryCase]
    var size: Int
    var viewedSize: Int {
        return isOpened ? self.size + 1 : 1
    }
    
    public init() {
        
        self.name = "Category"
        self.isOpened = false
        self.type = .category
        
        var _items: [CategoryCase] = [CategoryCase]()
        
        for categoryCase in CategoryCase.allCases{
            _items.append(categoryCase)
        }
        
        self.items = _items
        self.size = self.items.count
    }
    
    public func toggle(){
        self.isOpened.toggle()
    }
    
}

class SideMenuCountrySection: SideMenuBaseSection{
    
    typealias SectionType = CountryCase
    
    let type: SideMenuSectionType
    var name: String
    var isOpened: Bool
    var items: [CountryCase]
    var size: Int
    var viewedSize: Int {
        return isOpened ? self.size + 1 : 1
    }
    
    public init() {
        
        self.name = "Region"
        self.isOpened = false
        self.type = .region
        
        var _items: [CountryCase] = [CountryCase]()
        
        for countryCase in CountryCase.allCases{
            _items.append(countryCase)
        }
        
        self.items = _items
        self.size = self.items.count
    }
    
    public func toggle(){
        self.isOpened.toggle()
    }
    
}

public enum SideMenuSectionType: String, CaseIterable{
    
    case category
    case region
    
}
