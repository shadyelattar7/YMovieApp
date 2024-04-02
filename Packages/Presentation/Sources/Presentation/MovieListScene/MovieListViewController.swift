//
//  MovieListViewController.swift
//
//
//  Created by Al-attar on 02/04/2024.
//

import UIKit
import Extensions
import Combine

class MovieListViewController: UIViewController {
    
    // MARK: Identifier
    public static let Identifier = String(describing: MovieListViewController.self)
    
    
    //MARK: - @IBOutlet
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    //MARK: - Properties
    private var viewModel: MoviesListViewModel!
    private let cellScaling: CGFloat = 0.6
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - Private func
    private func bind() {
        viewModel.viewDidAppear()
        viewModel.$movies
            .sink { [weak self] _ in
                self?.movieCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setupCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        let nib = UINib(nibName: "MovieCell", bundle: Bundle.module)
        movieCollectionView.register(nib, forCellWithReuseIdentifier: "MovieCell")
        customLayout()
    }
    
    //MARK: - Public func
    public func configure(with viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: - Collection View Delegation and Data Source
extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: MovieCell.self, for: indexPath)
        viewModel.configrationCell(cell, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = self.viewModel.movies[indexPath.row]
        viewModel.handleAction(.openMovieDetails(selectedMovie))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230, height: 400)
    }
    
    func customLayout(){
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = movieCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        movieCollectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
    }
}

extension MovieListViewController: UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.movieCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
    }
}
