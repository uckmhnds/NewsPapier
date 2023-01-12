//
//  SideMenuRegionCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/11/23.
//

import UIKit
#warning("SideMenuBasCellA then inherit it here")
class SideMenuRegionCellA: UITableViewCell {
    
    static let identifier: String = "SideMenuRegionCellA"
    
    private var title = UILabel(autoLayout: false,
                                font: Theme.h1Title,
                                color: Theme.primaryText,
                                text: "Region")
    
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

class SideMenuRegionCellAA: UITableViewCell {
    
    static let identifier: String = "SideMenuRegionCellAA"
    
    private let title = UILabel(autoLayout: false,
                                font: Theme.body3,
                                color: Theme.secondaryText)
    
    private let flag = UILabel(autoLayout: false,
                                font: Theme.body3,
                                color: Theme.secondaryText)
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [flag, title])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    func setContent(_ countryCase: CountryCase){
        
        self.flag.text = countryCase.object.flag
        self.title.text = countryCase.object.name
        
    }
    
    private func applyConstraints(){
        
        stackView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: Inset.i1, left: Inset.i1, bottom: Inset.i1, right: Inset.i1))
        
        title.widthAnchor.constraint(equalTo: flag.widthAnchor, multiplier: 4).isActive = true
        
        flag.textAlignment = .center
        
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
