import Foundation

struct MottoItem: Codable, Identifiable {
    let id: Int
    let date_index: Int
    let word_cn: String
    let word_en: String
    let sentence_cn: String
    let sentence_en: String
    let author: String
}
