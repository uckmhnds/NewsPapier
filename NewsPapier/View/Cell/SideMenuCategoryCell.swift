//
//  SideMenuCategoryCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/11/23.
//

import UIKit

class SideMenuCategoryCellA: UITableViewCell {
    
    static let identifier: String = "SideMenuCategoryCellA"
    
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
                         padding: UIEdgeInsets(top: Inset.i1, left: Inset.i1, bottom: Inset.i1, right: Inset.i1))
        
    }
    
    func animateWhenSelected(){
        
        print("animation")
        
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        
        if state.isHighlighted{
            
        }
        
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


class SideMenuCategoryCellAA: UITableViewCell {
    
    static let identifier: String = "SideMenuCategoryCellAA"
    
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
    
    func setContent(_ categoryCase: CategoryCase){
        self.image.image = UIImage(systemName: categoryCase.object.symbol)
        self.title.text = categoryCase.object.name
    }
    
    private func applyConstraints(){
        
        stackView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: Padding.p1, left: Padding.p1, bottom: Padding.p1, right: Padding.p1))
        
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
        
        backgroundColor = Theme.tertiaryBackground
        
        addSubview(stackView)
        
        applyConstraints()
    }
    
}
