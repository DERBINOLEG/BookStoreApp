//
//  BookModel.swift
//  BookStoreApp
//
//  Created by Олег Дербин on 15.04.2025.
//

import Foundation

struct BookType: Hashable {
    let id = UUID()
    let type: String
    let books: [Book]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: BookType, rhs: BookType) -> Bool {
        lhs.id == rhs.id
    }
}

struct Book: Hashable {
    let id = UUID()
    let image: String
    let title: String
    var isNew = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs.id == rhs.id
    }
}
