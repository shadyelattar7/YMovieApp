//
//  File.swift
//  
//
//  Created by Al-attar on 01/04/2024.
//

import SwiftUI
import Combine
import Extensions
import Domain
import MoviesAPI
import AppEnvironment

// MARK: - MoviesListViewModel
public final class MoviesListViewModel: ObservableObject {
    
    // MARK: Private properties
    private let cancelBag: CancelBag
    private var currentPage = 1
    private var currentSort: MoviesSortingType = .popularity
    
    // MARK: Public properties
    @Published public var movies: [MovieAdapter] = []
    @Published public var showError = false
    @Published public var showingSortingOption = false
    public var isMorePagesAvailable = false
    
    // MARK: UseCases
    private let moviesUseCase: MoviesUseCaseProtocol
    private let environment: AppEnvironmentProtocol
    private let navigationHandler: NavigationActionHandler
    
    // MARK: Initialization
    public init(
        moviesUseCase: MoviesUseCaseProtocol,
        environment: AppEnvironmentProtocol,
        navigationHandler: @escaping NavigationActionHandler
    ) {
        self.cancelBag = .init()
        self.moviesUseCase = moviesUseCase
        self.environment = environment
        self.navigationHandler = navigationHandler
    }
}

extension MoviesListViewModel {
    func viewDidAppear() {
        loadMovies()
    }
    
    func loadMoreMovies() {
        currentPage += 1
        loadMovies()
    }
    
    func loadAllSortTypes() -> [MoviesSortingType] {
        return MoviesSortingType.allCases
    }
}

// MARK: - Actions
extension MoviesListViewModel {
    enum Actions {
        case sort(MoviesSortingType)
        case openMovieDetails(MovieAdapter)
    }
    
    func handleAction(_ action: Actions) {
        switch action {
        case .sort(let value):
            handleSortingAction(value)
        case .openMovieDetails(let adapter):
            handleOpenMovieDetailsAction(adapter)
        }
    }
    
    private func handleSortingAction(_ sort: MoviesSortingType) {
        guard sort != currentSort else { return }
        movies.removeAll()
        currentSort = sort
        currentPage = 1
        loadMovies()
    }
    
    private func handleOpenMovieDetailsAction(_ adapter: MovieAdapter) {
        navigationHandler(.openMovieDetails(adapter))
    }
}

// MARK: - API Caller
extension MoviesListViewModel {
    public func loadMovies() {
        moviesUseCase
            .getMovies(
                page: currentPage,
                sortType: currentSort
            )
            .receive(on: RunLoop.main)
            .toResult()
            .sink { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let response):
                    handleMovies(response)
                case .failure:
                    showError = true
                }
            }
            .store(in: cancelBag)
    }
    
    func handleMovies(_ response: MoviesListEntity) {
        isMorePagesAvailable = response.totalPages > response.page
        let imageBaseURL: String = environment.getValue(.apiImageBaseURL)
        movies.append(contentsOf: response.results.compactMap {
            MovieAdapter($0, baseImageURL: imageBaseURL)
        })
    }
}

// MARK: - Navigation
extension MoviesListViewModel {
    
    public typealias NavigationActionHandler = (MoviesListViewModel.NavigationAction) -> Void
    
    public enum NavigationAction {
        case openMovieDetails(MovieAdapter)
    }
}
