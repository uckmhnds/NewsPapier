//
//  UIStackView+.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/11/23.
//

import UIKit

class HStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.axis = .horizontal
    }
    
    convenience init(
        _ views: [UIView],
        autoLayout: Bool = false,
        alignment: Alignment = .fill,
        distribution: Distribution = .fill,
        spacing: CGFloat = 0
    ) {
        self.init(arrangedSubviews: views)
        self.translatesAutoresizingMaskIntoConstraints = autoLayout
        self.axis = .horizontal
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
}

class VStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
    }
    
    convenience init(
        _ views: [UIView],
        autoLayout: Bool = false,
        alignment: Alignment = .fill,
        distribution: Distribution = .fill,
        spacing: CGFloat = 0
    ) {
        self.init(arrangedSubviews: views)
        self.translatesAutoresizingMaskIntoConstraints = autoLayout
        self.axis = .vertical
        self.alignment = alignment
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.axis = .vertical
    }
}

extension UIStackView {

    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
