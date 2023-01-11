//
//  SideMenuCategoryCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/11/23.
//

import UIKit

#warning("Parametrize")

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
                         padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        title.widthAnchor.constraint(equalTo: image.widthAnchor, multiplier: 4).isActive = true
        
    }
    
    func animateWhenSelected(){
        
        print("animation")
        
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
