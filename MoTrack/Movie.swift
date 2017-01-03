//
//  Movie.swift
//  MoTrack
//
//  Created by Arinjay Sharma on 12/30/16.
//  Copyright © 2016 Arinjay Sharma. All rights reserved.
//

import Foundation

public struct Movie {
    
    static let APIKEY = "2cac5d5d212f47c9716eddb07d8ab491"
    public var title:String!
    public var imagePath:String!
    public var description:String!
    
    public init (title:String, imagePath:String, description:String){
        self.title = title
        self.description = description
        self.imagePath = imagePath
    }
    
    private static func getMovieData(with completion:@escaping (_ success:Bool, _ object:AnyObject?)->()){
    
        let session = URLSession(configuration: .default)
        
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(APIKEY)")!)
        
        
        session.dataTask(with: request){ (data:Data?, response:URLResponse?,error: Error?) in
            
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject?)
                }
                else{
                    completion( false, json as AnyObject?)
                }
            }
        }.resume()
    }
    
    public static func nowPlaying (with completion:@escaping (_ sucess:Bool,_ movies:[Movie]?)->()){
        Movie.getMovieData { (sucess, object) in
            print(object)
        }
    }
    
    
    
    
}
