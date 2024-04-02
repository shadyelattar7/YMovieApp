//
//  File.swift
//  
//
//  Created by Al-attar on 01/04/2024.
//

import Foundation
import Combine

// MARK: - MoviesUseCaseProtocol
public protocol MoviesUseCaseProtocol {
    /// Retrieves a list of movies from a remote data source.
    ///
    /// - Parameters:
    ///   - page: The page number to retrieve from the remote data source.
    ///   - sortType: The sorting type to apply to the movie list.
    /// - Returns: A Combine `AnyPublisher` that emits a `MoviesListEntity` or an error.
    func getMovies(
        page: Int,
        sortType: MoviesSortingType
    ) -> AnyPublisher<MoviesListEntity, Error>
    
    /// Retrieves detailed information for a specific movie.
    ///
    /// - Parameters:
    ///   - movieId: The unique identifier of the movie to retrieve details for.
    ///
    /// - Returns: A Combine `AnyPublisher` that emits a `MovieEntity` or an error.
    func getMovieDetails(
        movieId: Int
    ) -> AnyPublisher<MovieEntity, Error>

}

// MARK: - MoviesUseCase
public final class MoviesUseCase {
    
    // MARK: Private Properties
    private let repository: MoviesRepositoryProtocol
    
    // MARK: Initialization
    public init(repository: MoviesRepositoryProtocol) {
        self.repository = repository
    }
}

// MARK: - MoviesUseCaseProtocol
extension MoviesUseCase: MoviesUseCaseProtocol {
    public func getMovies(
        page: Int,
        sortType: MoviesSortingType
    ) -> AnyPublisher<MoviesListEntity, Error> {
        repository.getMovies(page: page,
                             sortType: sortType)
    }
    
    public func getMovieDetails(
        movieId: Int
    ) -> AnyPublisher<MovieEntity, Error> {
        repository.getMovieDetails(movieId: movieId)
    }
}
