//
//  ViewController.swift
//  BookStoreApp
//
//  Created by Олег Дербин on 12.04.2025.
//

import UIKit

class ViewController: UIViewController {
    
    //    MARK: UIElements
    private var collectionView: UICollectionView!
    
    //    MARK: Properties
    private let manager: IBookTypeManager = BookTypeManager()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - SetupUI
private extension ViewController {
    
    func setupUI() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(
            BookCollectionViewCell.self,
            forCellWithReuseIdentifier: BookCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        view.addSubview(collectionView)
        setupLayout()
    }
}

//MARK: - SetupLayout
private extension ViewController {
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 10,
            bottom: 5,
            trailing: 10
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.2),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        manager.getBookTypes().count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        manager.getBookTypes()[section].books.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookCollectionViewCell.identifier,
            for: indexPath
        ) as? BookCollectionViewCell else { return BookCollectionViewCell() }
        let book = manager.getBookTypes()[indexPath.section].books[indexPath.item]
        cell.configure(imageName: book.image, bookName: book.title)
        return cell
    }
}

