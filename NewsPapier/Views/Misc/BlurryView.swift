//
//  BlurryView.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/27/22.
//

import UIKit

final class BlurryView: UIView{
    
    private let superDelegate: MainViewControllerDelegate?
    
    @objc private func tapGestureDidTap(_ sender: UITapGestureRecognizer) {
        
        self.removeFromSuperview()
        
        superDelegate?.tapGestureDidTap()
    }
    
    public init(frame: CGRect,delegate: MainViewControllerDelegate?){
        self.superDelegate = delegate
        super.init(frame: frame)
        backgroundColor = .black
        alpha = 0.6
        let t = UITapGestureRecognizer(target: self, action: #selector(tapGestureDidTap))
        addGestureRecognizer(t)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
