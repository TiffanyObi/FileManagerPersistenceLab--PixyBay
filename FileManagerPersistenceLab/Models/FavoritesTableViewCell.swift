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
    
    @IBOutlet weak var viewsLabel: UILabel!
    
    
    var favoritedImage = Image?.self
    
    func configureCell(for favoriteImage: Image) {
        
        likesLabel.text = "Likes: \(String(favoriteImage.likes).dropLast(2))"
       
       viewsLabel.text = "Viewss: \(String(favoriteImage.views).dropLast(2))"
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
