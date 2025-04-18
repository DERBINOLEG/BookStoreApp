//
//  SectionHeaderView.swift
//  BookStoreApp
//
//  Created by Олег Дербин on 18.04.2025.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    
    //    MARK: UIElements
    lazy var headerLabel: UILabel = {
        $0.frame = self.bounds
        $0.textAlignment = .left
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        return $0
    }(UILabel())
    
//    MARK: Properties
    static let reuseIdentifier = "HeaderView"
    
//    MARK: Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Methods
    func configure(labelText: String) {
        headerLabel.text = labelText
    }
}
