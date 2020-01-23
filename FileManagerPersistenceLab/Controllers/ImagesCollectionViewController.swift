//
//  ImagesCollectionViewController.swift
//  FileManagerPersistenceLab
//
//  Created by Tiffany Obi on 1/21/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class ImagesCollectionViewController: UIViewController {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    
    @IBOutlet weak var searchQueryBar: UISearchBar!
    
    var searchQuery = "hearts" {
        didSet {
            DispatchQueue.main.async {
                self.getImages(with: self.searchQuery)
            }
        }
    }
    
    private var allImages = [Image](){
        didSet {
            DispatchQueue.main.async {
                self.imagesCollectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        imagesCollectionView.backgroundColor = .magenta
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        
        searchQueryBar.delegate = self
        
        getImages(with: searchQuery)
    }

    private func getImages(with searchQuery: String) {
        ImagesAPIClient.getImages(with: searchQuery) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("could not load images . Error : \(error)")
            case .success(let images):
                self?.allImages = images
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? ImageDetailViewController, let index = imagesCollectionView.indexPathsForSelectedItems?.first else {
            fatalError("could not find view controller for segue")
        }
        
        detailVC.imageDetails = allImages[index.row]
    }


}

extension ImagesCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImagesCollectionViewCell else {
         fatalError("could not downcast to ImagesCollectionViewCell  ")
        }
        
        let imageInRow = allImages[indexPath.row]
        
        imageCell.configureCell(for: imageInRow)
        return imageCell
    }
    
    
}

extension ImagesCollectionViewController: UICollectionViewDelegateFlowLayout{
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let interItemSpacing: CGFloat  = 10 //space between items
         let maxWidth = UIScreen.main.bounds.size.width //maximum screen width
         let numberOfItems: CGFloat = 2 // number of items per row
         let totalSpacing: CGFloat = numberOfItems * interItemSpacing
         let itemWidth:CGFloat = (maxWidth - totalSpacing) / numberOfItems
         return CGSize(width: itemWidth, height: itemWidth)
     }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension ImagesCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard !(searchBar.text?.isEmpty ?? true) else {
            getImages(with: "")
            return
        }
        searchQuery = searchBar.text ?? "rainbow"
    }
}
