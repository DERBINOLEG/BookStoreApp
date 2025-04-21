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
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    private let bookNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
//    MARK: Properties
    static let identifier = "BookCell"
    
//    MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        super.layoutSubviews()
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
        contentView.addSubview(bookImage)
        contentView.addSubview(bookNameLabel)
        setupLayout()
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
            
            bookNameLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 10),
            bookNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
