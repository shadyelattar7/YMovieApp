//
//  File.swift
//  
//
//  Created by Al-attar on 01/04/2024.
//

import SwiftUI
import Domain
import AppEnvironment

public struct MoviesListBuilder {
    
    private init() { }
    
    public static func build(
        moviesUseCase: MoviesUseCaseProtocol,
        environment: AppEnvironmentProtocol,
        navigationHandler: @escaping MoviesListViewModel.NavigationActionHandler
    ) -> UIViewController {
        let viewModel = MoviesListViewModel(
            moviesUseCase: moviesUseCase,
            environment: environment,
            navigationHandler: navigationHandler
        )
        let view = MoviesListView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
