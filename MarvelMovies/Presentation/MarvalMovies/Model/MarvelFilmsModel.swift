//
//  MarvelFilmsModel.swift
//  MarvelMovies
//
//  Created by kariman eltawel on 17/11/2023.
//

import Foundation
// MARK: - MarvelFilm
struct MarvelFilms: Codable {
    var code: Int?
    var status, copyright, attributionText, attributionHTML: String?
    var etag: String?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    var offset, limit, total, count: Int?
    var results: [FilmsResult]?
}

// MARK: - Result
struct FilmsResult: Codable {
    var id: Int?
    var title: String?
    var description: String?
    var resourceURI: String?
    var urls: [URLElement]?
    var startYear, endYear: Int?
    var rating: Rating?
    var type: String?
    var thumbnail: Thumbnail?
    var isSelected: Bool? = false
}

enum Rating: String, Codable {
    case empty = ""
    case marvelPsr = "Marvel Psr"
    case ratedT = "Rated T"
    case ratingRatedT = "Rated T+"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    var path: String?
    var thumbnailExtension: Extension?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case jpg = "jpg"
}
// MARK: - URLElement
struct URLElement: Codable {
    var type: String?
    var url: String?
}

enum URLType: String, Codable {
    case detail = "detail"
}

struct FilmsDetailsResult: Codable {
    var id: Int?
    var description: String?
    var endYear: Int?
}
