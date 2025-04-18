//
//  BadgeNewView.swift
//  BookStoreApp
//
//  Created by Олег Дербин on 18.04.2025.
//

import UIKit

class BadgeNewView: UICollectionReusableView {
    
    //    MARK: UIElements
    lazy var badgeLabel: UILabel = {
        $0.text = "Новинка"
        $0.textColor = .white
        $0.frame = self.bounds
        $0.backgroundColor = .systemPink
        $0.layer.cornerRadius = 12
        return $0
    }(UILabel())
    
//    MARK: Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(badgeLabel)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

