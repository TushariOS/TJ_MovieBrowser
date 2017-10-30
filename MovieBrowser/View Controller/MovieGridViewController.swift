//
//  ViewController.swift
//  MovieBrowser
//
//  Created by Tushar on 25/10/17.
//  Copyright © 2017 Tushar. All rights reserved.
//

import UIKit
import ACProgressHUD_Swift

class MovieGridViewController: UIViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    let movieListViewModel:MovieListViewModel = MovieListViewModel()
    var dataArray:[DataStruct.ResultData] = []
    var indexValue:Int = 0
    var pageNumber: Int = 0
    var isFlag = true
    var sortOrder: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        isFlag = true
        movieListViewModel.delegate = self
        registerMovieCell()
        pageNumber = pageNumber+1
        fetchMovie()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Movies"
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
    func fetchMovie()
    {
        if self.pageNumber == 1
        {
            ACProgressHUD.shared.showHUD()

        }

        let pageNumber = String(self.pageNumber)
        let reqObject = ["api_key" : "09dfe312d58bd712b3a9cb8b916d78dd", "page": pageNumber] as Dictionary<String, AnyObject>
        movieListViewModel.fetchMovieListAPI(requestObject: reqObject)

    }
    
    func fetchSortedMovie(sortOrder:String)
    {

        if self.pageNumber == 1
        {
         movieListViewModel.movielistDataArray.removeAll()
         movieCollectionView.reloadData()
         ACProgressHUD.shared.showHUD()
        }
        
        let pageNumber = String(self.pageNumber)
        let reqObject = ["api_key" : "09dfe312d58bd712b3a9cb8b916d78dd", "page": pageNumber,"sort_by": sortOrder ] as Dictionary<String, AnyObject>
        movieListViewModel.fetchSortOrderMovieListAPI(requestObject: reqObject)
        
    }

    
    @IBAction func SearchAction(_ sender: Any)
    {
        self.performSegue(withIdentifier: "SearchSegue", sender: self)
    }
    
    @IBAction func sortButtonAction(_ sender: Any)
    {
        
        let alertController = UIAlertController(title: "​Setting", message: "​Sort ​Order", preferredStyle: .actionSheet)
        
        let popularButton = UIAlertAction(title: "​Most Popular", style: .default, handler: { (action) -> Void in
            
            self.sortOrder = "popularity.desc"
            self.pageNumber = 1
            self.isFlag = false
            self.fetchSortedMovie(sortOrder: self.sortOrder)
            self.movieCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)

            
        })
        
        let rateButton = UIAlertAction(title: "​Higest rated", style: .default, handler: { (action) -> Void in
            
            self.sortOrder = "vote_average.desc"
            self.pageNumber = 1
            self.isFlag = false
            self.fetchSortedMovie(sortOrder: self.sortOrder)
            self.movieCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)

        })
        
        let defaultButton = UIAlertAction(title: "​Default", style: .default, handler: { (action) -> Void in
            
            self.pageNumber = 1
            self.isFlag = true
            self.movieListViewModel.movielistDataArray.removeAll()
            self.fetchMovie()
            self.movieCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)

        })


        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(popularButton)
        alertController.addAction(rateButton)
        alertController.addAction(defaultButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SearchSegue"
        {
            
        }
        else{
            let theDestination = (segue.destination as! MovieDetailViewController)
            theDestination.movieData = dataArray[indexValue]
            
        }
    }

}



 


extension MovieGridViewController: MovieListDelegate {
    
    func reloadListData(success: Bool)
    {
        if !success {
            // show aler
        }else{
            // reload list table
            ACProgressHUD.shared.hideHUD()

             dataArray = movieListViewModel.getMovieListData()
          // print(dataArray[0].original_title)
            movieCollectionView.reloadData()
        }
    }
    
}

