//
//  ImagesCollectionViewCell.swift
//  FileManagerPersistenceLab
//
//  Created by Tiffany Obi on 1/21/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import ImageKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagesImageView: UIImageView!
    
    var image = Image?.self
    
    func configureCell(for image: Image) {
        
        imagesImageView.getImage(with: image.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imagesImageView.image = UIImage(systemName: "photo.fill.on.rectangle.fill")
                }
            case .success( let image):
                DispatchQueue.main.async {
                    self?.imagesImageView.image = image
                }
                
            }
        }
        
    }
}
