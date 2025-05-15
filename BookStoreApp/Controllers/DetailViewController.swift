//
//  DetailViewController.swift
//  BookStoreApp
//
//  Created by Олег Дербин on 15.05.2025.
//

import UIKit

class DetailViewController: UIViewController {
    
    //    MARK: UIElements
    private let bookImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    private var favouriteButton: UIBarButtonItem?
    
    private let bookNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
//    MARK: Properties
    private var isFavourite = false
    
    //    MARK: Life Cycle
    init(bookName: String, imageName: String) {
        super.init(nibName: nil, bundle: nil)
        bookImage.image = UIImage(named: imageName)
        bookNameLabel.text = bookName
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //    MARK: - Methods
    @objc
    private func favouriteButtonTapped() {
        isFavourite.toggle()
        let imageName = isFavourite ? "heart.fill" : "heart"
        favouriteButton?.image = UIImage(systemName: imageName)
    }
    
}

//MARK: - SetupUI
private extension DetailViewController {
    func setupUI() {
        view.backgroundColor = .black
        view.addSubview(bookImage)
        view.addSubview(bookNameLabel)
        setupLayout()
        setupNavBar()
    }
    
    func setupNavBar() {
        navigationItem.title = "Book"
        favouriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(favouriteButtonTapped)
        )
        navigationItem.rightBarButtonItem = favouriteButton
    }
}

//MARK: - SetupLayout
private extension DetailViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            bookImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            bookImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            bookImage.heightAnchor.constraint(equalTo: bookImage.widthAnchor),
            
            bookNameLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 20),
            bookNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
