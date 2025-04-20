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
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
        collectionView.register(
            BadgeNewView.self,
            forSupplementaryViewOfKind: ElementKind.badge,
            withReuseIdentifier: BadgeNewView.reuseIdentifier
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
            leading: 10,
            bottom: 5,
            trailing: 10
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
    
    func createLayoutHeader(width: Double, height: Double) -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(width),
            heightDimension: .absolute(height)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem.init(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 10,
            bottom: 0,
            trailing: 0
        )
        return header
    }
    
    func createSupplementaryItem(width: Double, height: Double) -> NSCollectionLayoutSupplementaryItem {
        let supplementaryItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(width),
            heightDimension: .absolute(height)
        )
        let constraints = NSCollectionLayoutAnchor(
            edges: [.top, .leading],
            absoluteOffset: CGPoint(x: 0, y: -20)
        )
        let supplementaryItem = NSCollectionLayoutSupplementaryItem.init(
            layoutSize: supplementaryItemSize,
            elementKind: ElementKind.badge,
            containerAnchor: constraints
        )
        return supplementaryItem
    }
    
    func createTopSection() -> NSCollectionLayoutSection {
        let item = createLayoutItem(width: 120, height: 120, supplementaryItems: [])
        let group = createLayoutGroup(width: 1, height: 1, subItems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [createLayoutHeader(width: 1, height: 50)]
        return section
    }
    
    func createMiddleSection() -> NSCollectionLayoutSection {
        let badgeNew = createSupplementaryItem(width: 0.5, height: 20)
        let item = createLayoutItem(width: 150, height: 250, supplementaryItems: [badgeNew])
        let group = createLayoutGroup(width: 1, height: 1, subItems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [createLayoutHeader(width: 1, height: 50)]
        return section
    }
    
    func createBottomSection() -> NSCollectionLayoutSection {
        let badgeNew = createSupplementaryItem(width: 0.5, height: 20)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badgeNew])
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.6)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createLayoutHeader(width: 1, height: 50)]
        return section
    }
    
}

//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
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
        if indexPath.section == 0 {
            cell.layer.cornerRadius = cell.frame.width / 2
            cell.clipsToBounds = true
        } else {
            cell.clipsToBounds = false
        }
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let booksType = manager.getBookTypes()[indexPath.section].type
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as? SectionHeaderView else { return UICollectionReusableView() }
            header.configure(labelText: booksType)
            return header
        } else if kind == ElementKind.badge {
            guard let badgeNew = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: BadgeNewView.reuseIdentifier,
                for: indexPath
            ) as? BadgeNewView else { return UICollectionReusableView() }
            let book = manager.getBookTypes()[indexPath.section].books[indexPath.item]
            badgeNew.isHidden = book.isNew
            return badgeNew
        }
        return UICollectionReusableView()
    }
}

