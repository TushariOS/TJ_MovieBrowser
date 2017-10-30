//
//  MovieListViewModel.swift
//  MovieBrowser
//
//  Created by Tushar on 27/10/17.
//  Copyright © 2017 Tushar. All rights reserved.
//

import Foundation
import UIKit

@objc protocol MovieListDelegate{
    
    @objc optional
    func reloadListData(success: Bool)
}
class MovieListViewModel: NSObject
{
    var delegate:MovieListDelegate?
    
    var movieListModel: DataStruct.MovieList?
    
    var movielistDataArray = [DataStruct.ResultData]()

    
    func fetchMovieListAPI(requestObject: Dictionary<String, AnyObject>)
    
    {
      //  movielistDataArray = [ResultData]()

        let urlString:String = "https://api.themoviedb.org/4/list/1"
        
        WebserviceHandler().get(request: WebserviceHandler().getClientURLRequest(path: urlString, params: requestObject as Dictionary<String, AnyObject>)) { (success, object) -> () in
            DispatchQueue.main.async(execute: {
                
                self.mapToMovieListModel(response: object, success: success)
                
            })
            
        }
    }
    
    
    func fetchSearchMovieListAPI(requestObject: Dictionary<String, AnyObject>)
        
    {
        
        //as Dictionary<String, AnyObject>
        let urlString:String = "https://api.themoviedb.org/4/search/movie"
        
        WebserviceHandler().get(request: WebserviceHandler().getClientURLRequest(path: urlString, params: requestObject as Dictionary<String, AnyObject>)) { (success, object) -> () in
            DispatchQueue.main.async(execute: {
                
                self.mapToMovieListModel(response: object, success: success)
                
            })
            
        }
    }

    func fetchSortOrderMovieListAPI(requestObject: Dictionary<String, AnyObject>)
        
    {
        
        let urlString:String = "https://api.themoviedb.org/4/discover/movie"
        
        WebserviceHandler().get(request: WebserviceHandler().getClientURLRequest(path: urlString, params: requestObject as Dictionary<String, AnyObject>)) { (success, object) -> () in
            DispatchQueue.main.async(execute: {
                
                self.mapToMovieListModel(response: object, success: success)
                
            })
            
        }
    }
    

    // Used to map API response to Wishlist Model
    // Param: status -> Bool
    //        response -> Data Wishlist API response data
    // Return : nil

    func mapToMovieListModel(response: Data?, success:Bool){
        
        guard let response = response else {return}
        do{
            
            self.movieListModel = try JSONDecoder().decode(DataStruct.MovieList.self, from: response)
          // print(self.movieListModel?.results.count)
           delegate?.reloadListData!(success: true)
            
        }catch let jsonError
        {
            print(jsonError)
            delegate?.reloadListData!(success: false)
        }
        
    }
    
    func getMovieListData() -> [DataStruct.ResultData]
    {
       movielistDataArray  = movielistDataArray+self.movieListModel!.results
       return movielistDataArray
    }

}
