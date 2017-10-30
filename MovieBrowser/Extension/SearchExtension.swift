//
//  SearchExtension.swift
//  MovieBrowser
//
//  Created by Tushar on 28/10/17.
//  Copyright © 2017 Tushar. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePosterCollectionViewCell", for: indexPath) as! MoviePosterCollectionViewCell

        cell.movieTitleLabel.text = dataArray[indexPath.row].title
        
        print(dataArray[indexPath.row].poster_path as Any)
        
        if dataArray[indexPath.row].poster_path == nil
        {
            
        }else{
             let imageURL:String = "\(WebServiceUrls().IMAGE_BASE_URL)\(dataArray[indexPath.row].poster_path!)"
            
               cell.moviePosterImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       indexValue = indexPath.row
        self.performSegue(withIdentifier: "MovieDetailsSegue2", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        if dataArray.count > 0
        {
            if dataArray.count-1 == indexPath.row
            {
                pageNumber = pageNumber+1
                searchAPIMethod(searchQuery: searchBar.text!)
            }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat(collectionView.frame.size.width/2) - 10, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
        
        return sectionInsets
    }
    
}
