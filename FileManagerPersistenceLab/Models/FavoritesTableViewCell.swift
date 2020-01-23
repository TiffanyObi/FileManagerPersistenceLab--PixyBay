//
//  FavoritesTableViewCell.swift
//  FileManagerPersistenceLab
//
//  Created by Tiffany Obi on 1/22/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoritedImageView: UIImageView!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    var favoritedImage = Image?.self
    
    func configureCell(for favoriteImage: Image) {
        favoritedImageView.getImage(with: favoriteImage.largeImageURL) { (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.favoritedImageView.image = UIImage(systemName: "circle")
                }
                
            case .success(let image):
                DispatchQueue.main.async {
                    self.favoritedImageView.image = image
                }
            }
        }
    }
}
