//
//  ImageDetailViewController.swift
//  FileManagerPersistenceLab
//
//  Created by Tiffany Obi on 1/22/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import ImageKit


class ImageDetailViewController: UIViewController {

    @IBOutlet weak var singleImageView: UIImageView!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var commentsLabel: UILabel!
    
    @IBOutlet weak var downloadsLabel: UILabel!
    
    @IBOutlet weak var viewsLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var imageDetails: Image!
    
    var removeButton = false
    
    var dataPersistence = PersistenceHelper()
        
        
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        
    }
    
    

    private func updateUI() {
        
        view.backgroundColor = .magenta
        
        if removeButton == true {
            favoriteButton.isHidden = true
        }
        
        singleImageView.getImage(with: imageDetails.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.singleImageView.image = UIImage(systemName: "circle")
                }
                
            case .success(let image):
                DispatchQueue.main.async {
                    self?.singleImageView.image = image
                }
            }
        }
        
        likesLabel.text = "Likes: \(String(imageDetails.likes).dropLast(2))"
        
        commentsLabel.text = "Comments: \(String(imageDetails.comments).dropLast(2))"
        
        downloadsLabel.text = " Downloads : \(String(imageDetails.downloads).dropLast(2))"
        
        viewsLabel.text = "Views: \(String(imageDetails.views).dropLast(2)) "
    }
    
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
        sender.isEnabled = false
    
        
        
        dismiss(animated: true)
        
        do {
            try PersistenceHelper.shared.addToFavorites(item: imageDetails)
            
        } catch {
            print("saving error - Error: \(error)")
        }
        
    }
    
    
}
