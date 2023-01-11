//
//  SideMenuViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/14/22.
//

import UIKit
#warning("parametrize")

public enum SideMenuSectionCase: String, CaseIterable{
    
    case category
    case region
    
    var code: String { return self.rawValue }
    var name: String { return self.rawValue.capitalizeFirstLetter() }
    
    var size: Int {
        
        switch self{
            
        case .category:
            return CategoryCase.size + 1
        case .region:
            return 1
        }
        
    }
    
    var object: SideMenuSection{
        switch self{
            
        case .category:
            return SideMenuSection(isOpened: true)
        case .region:
            return SideMenuSection(isOpened: false)
        }
    }
    
}

struct SideMenuSection{
    
    var isOpened: Bool
    
}

protocol SideMenuViewControllerDelegate: AnyObject{
    func categorySelected(_ categoryCase: CategoryCase)
}

class SideMenuViewController: UIViewController {
    
//    var sections: [Section] = [Section(type: .sectionA, size: TestCategories.size, isOpened: false, elements: TestCategories.list),
//                               Section(type: .sectionB, size: 10, isOpened: false),
//                               Section(type: .sectionC, size: 12, isOpened: false)]
    #warning("parametrize")
    var sections: [SideMenuSectionCase] = [.category, .region]
    
    weak var delegate: SideMenuViewControllerDelegate?
    
    private lazy var tableView: UITableView = {
        #warning("Parametric frame set")
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(SideMenuCategoryCellA.self, forCellReuseIdentifier: SideMenuCategoryCellA.identifier)
        tableView.register(SideMenuRegionCellA.self, forCellReuseIdentifier: SideMenuRegionCellA.identifier)
        
        tableView.register(SideMenuCategoryCellAA.self, forCellReuseIdentifier: SideMenuCategoryCellAA.identifier)
        tableView.register(SideMenuRegionCellAA.self, forCellReuseIdentifier: SideMenuRegionCellAA.identifier)
        
        tableView.backgroundColor = Theme.primaryBackground
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private func applyConstraints(){
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
//            tableView.widthAnchor.constraint(equalToConstant: sideMenuWidth),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
//    func getSectionType(forSection: Int) -> SectionTypes {
//        return sections[forSection].type
//    }
//
//    func getSectionSize(forSection: Int) -> Int {
//        return sections[forSection].viewedSize
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Theme.primaryBackground
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        applyConstraints()
        
    }

}
