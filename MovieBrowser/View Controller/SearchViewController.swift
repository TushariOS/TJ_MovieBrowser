//
//  SearchViewController.swift
//  MovieBrowser
//
//  Created by Tushar on 28/10/17.
//  Copyright © 2017 Tushar. All rights reserved.
//

import UIKit
import ACProgressHUD_Swift

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var alertLabel: UILabel!
    
    let movieListViewModel:MovieListViewModel = MovieListViewModel()
    var dataArray:[DataStruct.ResultData] = []
    var indexValue:Int = 0
    var pageNumber: Int = 0

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        registerMovieCell()
        
        searchBar.delegate = self
        movieListViewModel.delegate = self
        self.alertLabel.isHidden = true

        pageNumber = pageNumber + 1

    }

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationItem.title = "Search"
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        self.navigationItem.title = ""
    }

    
    func registerMovieCell()
    {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        let nib = UINib(nibName: "MoviePosterCollectionViewCell", bundle: nil)
        movieCollectionView?.register(nib, forCellWithReuseIdentifier: "MoviePosterCollectionViewCell")
        
    }
    


    // MARK: SearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        movieListViewModel.movielistDataArray.removeAll()
        movieCollectionView.reloadData()
        self.movieCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        self.pageNumber = 1
        
        
        searchAPIMethod(searchQuery: searchBar.text!)

    }

    func searchAPIMethod(searchQuery: String)
    {
        if self.pageNumber == 1
        {
            ACProgressHUD.shared.showHUD()
        }

        let pageNumber = String(self.pageNumber)
        
        let reqObject = ["api_key" : "09dfe312d58bd712b3a9cb8b916d78dd", "query": searchQuery, "page": pageNumber] as Dictionary<String, AnyObject>
        movieListViewModel.fetchSearchMovieListAPI(requestObject: reqObject)

    }


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let theDestination = (segue.destination as! MovieDetailViewController)
        theDestination.movieData = dataArray[indexValue]
    }
 

}
extension SearchViewController: MovieListDelegate {
    
    func reloadListData(success: Bool)
    {
        if !success {
            // show aler
        }else{
            // reload list table
            ACProgressHUD.shared.hideHUD()
            dataArray = movieListViewModel.getMovieListData()
            movieCollectionView.reloadData()
            
            if pageNumber ==  1
            {
                if dataArray.count == 0
                {
                    
                    self.alertLabel.isHidden = false
                    
                }
                else
                {
                    self.alertLabel.isHidden = true
                    
                }
            }

        }
    }
    
}
