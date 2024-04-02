//
//  File.swift
//  
//
//  Created by Al-attar on 01/04/2024.
//

import Foundation

/// Represents different sorting types for movies.
public enum MoviesSortingType: String, CaseIterable {
    /// Sort movies by popularity.
    case popularity = "Popularity"
    
    /// Sort movies by revenue.
    case revenue = "Revenue"
    
    /// Sort movies by vote primary release date.
    case primaryReleaseDate = "Primary Release Date"
    
    /// Sort movies by vote average.
    case voteAverage = "Vote Average"
    
    /// Sort movies by vote count.
    case voteCount = "Vote Count"
    
    /// The corresponding value used for sorting in API requests.
    public var apiValue: String {
        switch self {
        case .popularity:
            return "popularity.desc"
        case .revenue:
            return "revenue.desc"
        case .primaryReleaseDate:
            return "primary_release_date.desc"
        case .voteAverage:
            return "vote_average.desc"
        case .voteCount:
            return "vote_count.desc"
        }
    }
}
