//
//  Order.swift
//  shoppingApplication

import Foundation

// MARK: - Order
struct Order: Codable {
    let order: [OrderElement]
}

// MARK: - OrderElement
struct OrderElement: Codable {
    let durum: Bool
    let mesaj: String
}
