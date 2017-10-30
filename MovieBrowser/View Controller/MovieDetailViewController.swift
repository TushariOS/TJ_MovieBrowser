//
//  MovieDetailViewController.swift
//  MovieBrowser
//
//  Created by Tushar on 28/10/17.
//  Copyright © 2017 Tushar. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieTavleView: UITableView!
    
    var movieData:DataStruct.ResultData! = nil
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var totalVoteLabel: UILabel!
    @IBOutlet weak var releaseDateLabe: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupData()
        
        self.navigationItem.title = "Movie Details"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func setupData()
    {
       

        if movieData.poster_path == nil
        {
            
        }else{
            let imageURL:String = "\(WebServiceUrls().IMAGE_BASE_URL)\(movieData.poster_path!)"
            movieImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        }

        titleMovieLabel.text = movieData.original_title
        ratingLabel.text = "Rating: \(movieData.vote_average!)"
        totalVoteLabel.text = "Total Votes: \(movieData.vote_count!)"
        releaseDateLabe.text = "Relase Date: \(movieData.release_date!)"
        overviewLabel.text =  movieData.overview

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
