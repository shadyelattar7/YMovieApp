//
//  MovieEntity.swift
//  
//
//  Created by Al-attar on 01/04/2024.
//

import Foundation

public struct MovieEntity: Decodable, Equatable {
    public let adult: Bool
    public let backdropPath: String?
    public let genreIDS: [Int]
    public let id: Int
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String
    public let popularity: Double
    public let posterPath: String?
    public let releaseDate: String?
    public let title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    private init(
        adult: Bool,
        backdropPath: String?,
        genreIDS: [Int],
        id: Int,
        originalLanguage: String,
        originalTitle: String,
        overview: String,
        popularity: Double,
        posterPath: String?,
        releaseDate: String?,
        title: String,
        video: Bool,
        voteAverage: Double,
        voteCount: Int
    ) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

extension MovieEntity {
    public static var mock: Self {
        .init(
            adult: false,
            backdropPath: "",
            genreIDS: [1, 2, 3],
            id: 1,
            originalLanguage: "en",
            originalTitle: "Title",
            overview: "OverView",
            popularity: 20,
            posterPath: "",
            releaseDate: nil,
            title: "Title",
            video: true,
            voteAverage: 4.9,
            voteCount: 4
        )
    }
}
