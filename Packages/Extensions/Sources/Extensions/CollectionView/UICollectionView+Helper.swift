//
//  UICollectionView+Helper.swift
//
//
//  Created by Al-attar on 02/04/2024.
//

import UIKit

public extension UICollectionView {
    
     func registerNIB<Cell: UICollectionViewCell>(_: Cell.Type) {
        let identifier = String(describing: Cell.self)
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
       func dequeue<Cell: UICollectionViewCell>(cell: Cell.Type, for index: IndexPath) -> Cell {
        let identifier = String(describing: cell.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: index) as? Cell else {
            fatalError("Unable to Dequeue Reusable Collection View Cell with identifier: \(identifier)")
        }
        return cell
    }
}

public extension UICollectionView{
    func resizeItem(width: CGFloat? = nil, height: CGFloat? = nil){
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout{
            if let width = width {
                layout.itemSize.width = width
            }
            if let height = height {
                layout.itemSize.height = height
            }
        }
    }
}
