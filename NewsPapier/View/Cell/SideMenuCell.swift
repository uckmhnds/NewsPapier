//
//  SideMenuCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/15/22.
//

import UIKit

enum Fruits {
    static let fruits = ["apple", "avacoda", "cherry", "coconut", "dragon" ,"grapes",
                         "guava", "kiwi", "melom", "orange", "peach", "salak", "straw"]
}


struct SideMenuCategories{
    
    static let categoryNames: [String] = ["Business",
                                          "Entertainment",
                                          "General",
                                          "Health",
                                          "Science",
                                          "Sports",
                                          "Technology"]
    
}

final class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView = UIStackView()
    private let cellView = CustomTableCellView()
    private let detailView = CustomTableDetailView()
    
    func setUI(with index: Int) {
        cellView.setUI(with: SideMenuCategories.categoryNames[index])
        detailView.setUI(with: Fruits.fruits[index],
                         image: UIImage(named: Fruits.fruits[index]) ?? UIImage())
    }
    
    func commonInit() {
        selectionStyle = .none
        detailView.isHidden = true

        
        containerView.axis = .vertical

        contentView.addSubview(containerView)
        containerView.addArrangedSubview(cellView)
        containerView.addArrangedSubview(detailView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        cellView.translatesAutoresizingMaskIntoConstraints = false
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
}

extension CustomTableViewCell {
    var isDetailViewHidden: Bool {
        return detailView.isHidden
    }

    func showDetailView() {
        detailView.isHidden = false
    }

    func hideDetailView() {
        detailView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isDetailViewHidden, selected {
            showDetailView()
        } else {
            hideDetailView()
        }
    }
}








final class SideMenuMainCell: UITableViewCell {
    
    static let identifier = "SideMenuMainCell"
    
    private lazy var cellView: SideMenuMainCellView = {
        
        let view = SideMenuMainCellView(frame: .zero)
        
        return view
        
    }()
    
    private func applyConstraints(){
        
        let cellViewConstraints = [
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(cellViewConstraints)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(cellView)
        
        applyConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

final class SideMenuMainCellView: UIView {
    
    private lazy var imageView: UIImageView = {
        
        let view = UIImageView()
        
        return view
        
    }()
    
    private lazy var label: UILabel = {
        
        let label = UILabel()
        
        return label
        
    }()
    
    func setContent(){
        
    }
    
    private func applyConstraints(){
        
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(labelConstraints)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        applyConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

final class SideMenuChildCell: UITableViewCell{
    
    static let identifier = "SideMenuMainCell"
    
    private lazy var cellView: SideMenuChildCellView = {
        
        let view = SideMenuChildCellView(frame: .zero)
        
        return view
        
    }()
    
    private func applyConstraints(){
        
        let cellViewConstraints = [
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(cellViewConstraints)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(cellView)
        
        applyConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SideMenuChildCellView: UIView {
    
    private let offset: CGFloat = 8
    
    private lazy var label: UILabel = {
        
        let label = UILabel()
        
        return label
        
    }()
    
    private func applyConstraints(){
        
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: trailingAnchor, constant: offset),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
        
    }
    
    func setContent(){
        label.text = "🇬🇧 Great Britain"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        
        applyConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
