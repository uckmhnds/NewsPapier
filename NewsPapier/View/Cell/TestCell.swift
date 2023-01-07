//
//  TestCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/7/23.
//

import UIKit

class ExpColCell: UITableViewCell {
    
    static let identifier: String = "ExpColCell"

    public var didChangeHeight: ((Bool) -> ())?
    
    private let stack = UIStackView()
    private let topLabel = UILabel()
    private let botLabel = UILabel()
    private let toggleButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit() -> Void {
        // button properties
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.backgroundColor = .systemBlue
        toggleButton.setTitleColor(.white, for: .normal)
        toggleButton.setTitleColor(.gray, for: .highlighted)
        toggleButton.setTitle("Collapse", for: [])
        
        // label properties
        topLabel.text = "Top Label"
        botLabel.text = "Bottom Label"
        topLabel.font = .systemFont(ofSize: 32.0)
        botLabel.font = .italicSystemFont(ofSize: 24.0)
        topLabel.backgroundColor = .green
        botLabel.backgroundColor = .systemTeal
        
        botLabel.numberOfLines = 0
        
        // outline view properties
        
        // stack view properties
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        
        // add the labels
        stack.addArrangedSubview(topLabel)
        stack.addArrangedSubview(botLabel)
        
        // add outlineView, stack view and button to contentView
//        contentView.addSubview(outlineView)
        contentView.addSubview(stack)
        contentView.addSubview(toggleButton)
        
        // we'll use the margin guide
        let g = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            
            stack.topAnchor.constraint(equalTo: g.topAnchor),
            stack.leadingAnchor.constraint(equalTo: g.leadingAnchor),
            
//            outlineView.topAnchor.constraint(equalTo: stack.topAnchor),
//            outlineView.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
//            outlineView.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
//            outlineView.bottomAnchor.constraint(equalTo: stack.bottomAnchor),

            toggleButton.topAnchor.constraint(equalTo: g.topAnchor),
            toggleButton.trailingAnchor.constraint(equalTo: g.trailingAnchor),
            toggleButton.leadingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 16.0),
            toggleButton.widthAnchor.constraint(equalToConstant: 92.0),
            
        ])
        
        // we set the bottomAnchor constraint like this to avoid intermediary auto-layout warnings
        let c = stack.bottomAnchor.constraint(equalTo: g.bottomAnchor)
        c.priority = UILayoutPriority(rawValue: 999)
        c.isActive = true

        // set label Hugging and Compression to prevent them from squeezing/stretching
        topLabel.setContentHuggingPriority(.required, for: .vertical)
        topLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        botLabel.setContentHuggingPriority(.required, for: .vertical)
        botLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        contentView.clipsToBounds = true
        
        toggleButton.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
        
    }
    
    func setData(_ str1: String, str2: String, isCollapsed: Bool) -> Void {
        topLabel.text = str1
        botLabel.text = str2
        botLabel.isHidden = isCollapsed
        updateButtonTitle()
    }
    func updateButtonTitle() -> Void {
        let t = botLabel.isHidden ? "Expand" : "Collapse"
        toggleButton.setTitle(t, for: [])
    }
    
    @objc func toggleButtonTapped() -> Void {
        botLabel.isHidden.toggle()
        updateButtonTitle()
        
        // comment / un-comment this line to see the difference
        didChangeHeight?(botLabel.isHidden)
    }
}
