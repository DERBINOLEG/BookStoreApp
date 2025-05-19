//
//  MultipleSectionsViewController.swift
//  BookStoreApp
//
//  Created by Олег Дербин on 19.05.2025.
//

import UIKit

class MultipleSectionsViewController: UIViewController {
    
    //    MARK: UIElements
    private var collectionView: UICollectionView!
    
    //    MARK: Properties
    private let reuseIdentifier = "reuseIdentifier"
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - SetupUI
private extension MultipleSectionsViewController {
    
    func setupUI() {
        view.backgroundColor = .black
        navigationItem.title = "Search"
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: reuseIdentifier
        )
        
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        view.addSubview(collectionView)
        setupLayout()
    }
}

//MARK: - SetupLayout
private extension MultipleSectionsViewController {
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                return self.createTopSection()
            } else if sectionIndex == 1 {
                return self.createMiddleSection()
            } else {
                return self.createBottomSection()
            }
        }
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
    
    func createLayoutItem(
        width: Double,
        height: Double,
        supplementaryItems: [NSCollectionLayoutSupplementaryItem]
    ) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(width),
            heightDimension: .absolute(height)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: supplementaryItems )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 20,
            leading: 20,
            bottom: 20,
            trailing: 20
        )
        return item
    }
    
    func createLayoutGroup(
        width: Double,
        height: Double,
        subItems: [NSCollectionLayoutItem]
    ) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(width),
            heightDimension: .estimated(height)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: subItems
        )
        return group
    }
    
    
    func createTopSection() -> NSCollectionLayoutSection {
        let item = createLayoutItem(width: 160, height: 160, supplementaryItems: [])
        let group = createLayoutGroup(width: 1, height: 1, subItems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func createMiddleSection() -> NSCollectionLayoutSection {
        let item = createLayoutItem(width: 170, height: 250, supplementaryItems: [])
        let group = createLayoutGroup(width: 1, height: 1, subItems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func createBottomSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [])
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.6)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
}

extension MultipleSectionsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if indexPath.section == 0 {
            cell.layer.cornerRadius = cell.bounds.width / 2
            cell.backgroundColor = .purple
        } else if indexPath.section == 1 {
            cell.backgroundColor = .blue
            cell.layer.cornerRadius = 20
        } else {
            cell.backgroundColor = .cyan
            cell.layer.cornerRadius = 20
        }
        return cell
    }
    
    
}
