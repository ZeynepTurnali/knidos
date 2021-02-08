
import Foundation

// MARK: - UserSignUp
struct UserSignUp: Codable {
    let user: [Register]
}

// MARK: - User
struct Register: Codable {
    let durum: Bool
    let mesaj: String
    let kullaniciID: String?

    enum CodingKeys: String, CodingKey {
        case durum, mesaj
        case kullaniciID = "kullaniciId"
    }
}

