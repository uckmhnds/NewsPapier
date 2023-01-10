//
//  SideMenuViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/14/22.
//

import UIKit
#warning("parametrize")

enum SectionTypes { case sectionA, sectionB, sectionC }

struct Section{
    
    let type: SectionTypes
    var size: Int
    var isOpened: Bool
    var viewedSize: Int { return isOpened ? size + 1 : 1}
    var elements: [TestCategory]
    
}

protocol SideMenuViewControllerDelegate: AnyObject{
    func categorySelected(_ category: TestCategory)
}

class SideMenuViewController: UIViewController {
    
//    var sections: [Section] = [Section(type: .sectionA, size: TestCategories.size, isOpened: false, elements: TestCategories.list),
//                               Section(type: .sectionB, size: 10, isOpened: false),
//                               Section(type: .sectionC, size: 12, isOpened: false)]
    #warning("parametrize")
    var sections: [Section] = [Section(type: .sectionA, size: TestCategories.size, isOpened: false, elements: TestCategories.list)]
    
    weak var delegate: SideMenuViewControllerDelegate?
    
    private lazy var tableView: UITableView = {
        #warning("Parametric frame set")
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(CellA.self, forCellReuseIdentifier: CellA.identifier)
        tableView.register(CellB.self, forCellReuseIdentifier: CellB.identifier)
        tableView.register(CellC.self, forCellReuseIdentifier: CellC.identifier)
        
        tableView.register(CellAA.self, forCellReuseIdentifier: CellAA.identifier)
        tableView.register(CellBB.self, forCellReuseIdentifier: CellBB.identifier)
        tableView.register(CellCC.self, forCellReuseIdentifier: CellCC.identifier)
        
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
    
    func getSectionType(forSection: Int) -> SectionTypes {
        return sections[forSection].type
    }
    
    func getSectionSize(forSection: Int) -> Int {
        return sections[forSection].viewedSize
    }
    
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

#warning("Parametrize")

class CellA: UITableViewCell {
    
    static let identifier: String = "CellA"
    
    private var title = UILabel(autoLayout: false,
                                font: Theme.h1Title,
                                color: Theme.primaryText,
                                text: "Categories")
    
    private var image = UIImageView(image: UIImage(systemName: "chevron.down"),
                                    contentMode: .center,
                                    autoLayout: false,
                                    clipsToBounds: false,
                                    tintColor: Theme.tertiaryText)
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [title, image])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.distribution = .equalSpacing
        view.axis = .horizontal
        return view
    }()
    
    private func applyConstraints(){
        
        stackView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        title.widthAnchor.constraint(equalTo: image.widthAnchor, multiplier: 4).isActive = true
        
    }
    
    func animateWhenSelected(){
        
        
        
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
//            let angle = CGFloat.pi / 2
//            self.image.transform = CGAffineTransform(rotationAngle: angle)
//        } completion: { _ in
//            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
//                let angle = CGFloat.pi
//                self.image.transform = CGAffineTransform(rotationAngle: angle)
//            } completion: { _ in
//                UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
//                    let angle = CGFloat.pi * 3 / 2
//                    self.image.transform = CGAffineTransform(rotationAngle: angle)
//                } completion: { _ in
//                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
//                        let angle = CGFloat.pi * 2
//                        self.image.transform = CGAffineTransform(rotationAngle: angle)
//                    }
//                }
//            }
//        }
//
//    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        
        if state.isHighlighted{
            
//            UIView.animateKeyframes(withDuration: 2, delay: 0) {
//                for i in 0..<4 {
//                    UIView.addKeyframe(withRelativeStartTime: 0.25 * Double(i),
//                        relativeDuration: 0.25) {
//                            let angle = CGFloat.pi / 8 * CGFloat(i + 1)
//                        self.image.transform = CGAffineTransform(rotationAngle: angle)
//                        print(angle)
//                    }
//                }
//            }
//            self.image.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
//            self.image.rotate()
            
        }
        
//        var contentConfig = defaultContentConfiguration().updated(for: state)
//        contentConfig.text = "Hello World"
//        contentConfig.image = UIImage(systemName: "bell")
//
//        var backgroundConfig = backgroundConfiguration?.updated(for: state)
//        backgroundConfig?.backgroundColor = .purple
//
//        if state.isHighlighted || state.isSelected {
//            backgroundConfig?.backgroundColor = .orange
//            contentConfig.textProperties.color = .red
//            contentConfig.imageProperties.tintColor = .yellow
//        }
//
//        contentConfiguration = contentConfig
//        backgroundConfiguration = backgroundConfig
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Theme.secondaryBackground
        
        addSubview(stackView)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = Theme.secondaryBackground
        
        addSubview(stackView)
        
        applyConstraints()
    }
    
}


class CellAA: UITableViewCell {
    
    static let identifier: String = "CellAA"
    
    private let title = UILabel(autoLayout: false,
                                font: Theme.body3,
                                color: Theme.secondaryText)
    
    private let image = UIImageView(contentMode: .center,
                                    autoLayout: false,
                                    clipsToBounds: false,
                                    tintColor: Theme.tertiaryText)
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [image, title])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    func setContent(_ testCategory: TestCategory){
        self.image.image = UIImage(systemName: testCategory.symbol)
        self.title.text = testCategory.name
    }
    
    private func applyConstraints(){
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        title.widthAnchor.constraint(equalTo: image.widthAnchor, multiplier: 4).isActive = true
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Theme.tertiaryBackground
        
        addSubview(stackView)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

class CellB: UITableViewCell {
    
    static let identifier: String = "CellB"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

class CellBB: UITableViewCell {
    
    static let identifier: String = "CellBB"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

class CellC: UITableViewCell {
    
    static let identifier: String = "CellC"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

class CellCC: UITableViewCell {
    
    static let identifier: String = "CellCC"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
