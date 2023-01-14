//
//  HomeCollection.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/14/23.
//

import Foundation
/*
protocol HomeCategoryFactory {

    func createProjector() -> Projector

    func syncedProjector(with projector: Projector) -> Projector
}

extension HomeCategoryFactory {

    /// Base implementation of ProjectorFactory

    func syncedProjector(with projector: Projector) -> Projector {

        /// Every instance creates an own projector
        let newProjector = createProjector()

        /// sync projectors
        newProjector.sync(with: projector)

        return newProjector
    }
}

class WifiFactory: HomeCategoryFactory {

    func createProjector() -> Projector {
        return WifiProjector()
    }
}

class BluetoothFactory: HomeCategoryFactory {

    func createProjector() -> Projector {
        return BluetoothProjector()
    }
}

protocol Projector {

    /// Abstract projector interface

    var currentPage: Int { get }

    func present(info: String)

    func sync(with projector: Projector)

    func update(with page: Int)
}

extension Projector {

    /// Base implementation of Projector methods

    func sync(with projector: Projector) {
        projector.update(with: currentPage)
    }
}

class WifiProjector: Projector {

    var currentPage = 0

    func present(info: String) {
        print("Info is presented over Wifi: \(info)")
    }

    func update(with page: Int) {
        /// ... scroll page via WiFi connection
        /// ...
        currentPage = page
    }
}

class BluetoothProjector: Projector {

    var currentPage = 0

    func present(info: String) {
        print("Info is presented over Bluetooth: \(info)")
    }

    func update(with page: Int) {
        /// ... scroll page via Bluetooth connection
        /// ...
        currentPage = page
    }
}

private class ClientCode {

    private var currentProjector: Projector?

    func present(info: String, with factory: HomeCategoryFactory) {

        /// Check wheater a client code already present smth...

        guard let projector = currentProjector else {

            /// 'currentProjector' variable is nil. Create a new projector and
            /// start presentation.

            let projector = factory.createProjector()
            projector.present(info: info)
            self.currentProjector = projector
            return
        }

        /// Client code already has a projector. Let's sync pages of the old
        /// projector with a new one.

        self.currentProjector = factory.syncedProjector(with: projector)
        self.currentProjector?.present(info: info)
    }
}
*/


protocol HomeCollectionBaseSection{
    
    var type: HomeCollectionSectionType {get}
    var name: String { get }
    
}

class HomeCollectionFinanceSection: HomeCollectionBaseSection{
    
    let type: HomeCollectionSectionType
    var name: String
    
    public init (){
        self.type = .finance
        self.name = "Finance"
        
    }
    
}

class HomeCollectionWeatherSection: HomeCollectionBaseSection{
    
    let type: HomeCollectionSectionType
    var name: String
    
    public init (){
        self.type = .weather
        self.name = "Weather"
        
    }
    
}

class HomeCollectionCategorySection: HomeCollectionBaseSection{
    
    let type: HomeCollectionSectionType
    var name: String
    var _case: CategoryCase
    
    public init (_ categoryCase: CategoryCase){
        
        self.type = .news
        self.name = categoryCase.code.capitalizeFirstLetter()
        self._case = categoryCase
    }
    
}


public enum HomeCollectionSectionType: String, CaseIterable{
    
    case finance
    case weather
    case news
    
}

extension HomeCollectionSectionType{
    
    var code: String { return self.rawValue }
    var name: String { return self.rawValue.capitalizeFirstLetter()  }
    
}
