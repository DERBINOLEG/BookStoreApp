//
//  BookCollectionViewCell.swift
//  BookStoreApp
//
//  Created by Олег Дербин on 16.04.2025.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
//    MARK: UIElements
    private let bookImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    private let bookNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
//    MARK: Properties
    let identifier = "BookCell"
    
//    MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Methods
    func configure(imageName: String, bookName: String) {
        bookImage.image = UIImage(named: imageName)
        bookNameLabel.text = bookName
    }
}

//MARK: - SetupUI
private extension BookCollectionViewCell {
    func setupUI() {
        addSubview(bookImage)
        addSubview(bookNameLabel)
    }
}

//MARK: - SetupLayout
private extension BookCollectionViewCell {
    func setupLayout() {
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            bookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bookImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            
            bookNameLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor),
            bookNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
