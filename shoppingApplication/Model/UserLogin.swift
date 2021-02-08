//
//  UserLogin.swift
//  shoppingApplication

import Foundation

import Foundation

// MARK: - Welcome
struct UserLogin: Codable {
    let user: [User]
}

// MARK: - User
struct User: Codable {
    let durum: Bool
    let mesaj: String
    let bilgiler: Bilgiler?
}

// MARK: - Bilgiler
struct Bilgiler: Codable {
    let userID, userName, userSurname, userEmail: String
    let userPhone, face, faceID: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userName, userSurname, userEmail, userPhone, face, faceID
    }
}
