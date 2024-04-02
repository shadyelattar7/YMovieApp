//
//  File.swift
//  
//
//  Created by Al-attar on 01/04/2024.
//

import SwiftUI
import ImageCache

// MARK: - MovieRowView
struct MovieRowView: View {
    
    // MARK: Private Properties
    private let movie: MovieAdapter
    private let selectionHandler: (MovieAdapter) -> Void

    // MARK: Initialization
    public init(
        movie: MovieAdapter,
        selectionHandler: @escaping (MovieAdapter) -> Void
    ) {
        self.movie = movie
        self.selectionHandler = selectionHandler
    }
    
    // MARK: Body
    var body: some View {
        HStack(alignment: .center, spacing: Sizes.horizontalSpacing) {
            RemoteImageView(
                resource: RemoteImageResource(
                    path: movie.posterTiny,
                    placeholder: nil
                )
            )
            .frame(width: Sizes.imageWidth)
            .clipped()
            .cornerRadius(Sizes.imageCornerRadius)
            
            VStack(alignment: .leading, spacing: Sizes.verticalSpacing) {
                Text(movie.title)
                    .font(.title3)
                Text(movie.overview)
                    .lineLimit(3)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, Sizes.viewPadding)
        .onTapGesture {
            selectionHandler(movie)
        }
    }
}

// MARK: - Sizes
private extension MovieRowView {
    struct Sizes {
        static let horizontalSpacing: CGFloat = 16
        static let verticalSpacing:   CGFloat = 8
        static let imageWidth:        CGFloat = 80
        static let imageCornerRadius: CGFloat = 8
        static let viewPadding:       CGFloat = 4
    }
}
