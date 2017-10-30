//
//  MovieListModel.swift
//  MovieBrowser
//
//  Created by Tushar on 27/10/17.
//  Copyright © 2017 Tushar. All rights reserved.
//

import Foundation
import UIKit
struct DataStruct
{
    struct MovieList: Decodable
    {
        //let id:Int
        let page: Int
        let total_results: Int
        let results: [ResultData]
        
    }
    struct ResultData: Decodable {
        let vote_average: Float?
        let vote_count: Int?
        let id: Int?
        let video: Bool?
        let media_type: String?
        let title: String?
        let popularity: Double
        let poster_path: String?
        let original_language: String?
        let original_title: String
        let backdrop_path: String?
        let adult: Bool?
        let overview: String?
        let release_date: String?
        
        
    }
    var poster_path: String
  //  var detail: String
    
    struct Genre_ids: Decodable
    {
        
        
    }
    
    struct CodingKeys: CodingKey {
        var intValue: Int?
        var stringValue: String
        
        init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
        init?(stringValue: String) { self.stringValue = stringValue }
        
        static let poster_path = CodingKeys(stringValue: "results")!
        static func makeKey(poster_path: String) -> CodingKeys {
            return CodingKeys(stringValue: poster_path)!
        }
    }
    
    init(from coder: Decoder) throws {
        let container = try coder.container(keyedBy: CodingKeys.self)
        self.poster_path = try container.decode(String.self, forKey: .poster_path)
        //self.detail = try container.decode([Detail].self, forKey: .makeKey(name: name)).first!
    }


}


