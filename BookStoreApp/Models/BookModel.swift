//
//  BookModel.swift
//  BookStoreApp
//
//  Created by Олег Дербин on 15.04.2025.
//

import Foundation

struct BookType: Hashable {
    let type: String
    let books: [Book]
}

struct Book: Hashable {
    let image: String
    let title: String
    var isNew = false
}
