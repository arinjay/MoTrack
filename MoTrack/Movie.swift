//
//  Movie.swift
//  MoTrack
//
//  Created by Arinjay Sharma on 12/30/16.
//  Copyright © 2016 Arinjay Sharma. All rights reserved.
//

import UIKit


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
            //print(object)
            if sucess {
                var movieArray = [Movie]()
                
                if let movieResults = object?["results"] as? [Dictionary< String,AnyObject>]{
                    for movie in movieResults{
                        let title = movie["original_title"] as! String
                        let description = movie["overview"] as! String
                        guard let poster = movie["poster_path"] as? String
                            else{continue}
                        
                        let movieObj = Movie(title: title, imagePath: poster , description: description)
                        movieArray.append(movieObj)
                    }
                    completion(true, movieArray)
                }
                else{ completion(false, nil)}
            }
            
        }
    }
    
}

private func getDocumentsDirectory () -> String? {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    guard let documents:String = paths.first else {return nil}
    
    return documents
}

private func checkForImageData (withMovieObject movie:Movie) -> String? {
    
    if let documents = getDocumentsDirectory(){
        let moviePath = documents + "\(movie.title)"
        
         let escapedImagePath = movieImagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if FileManager.default.fileExists(atPath: escapedImagePath!) {
            return escapedImagePath
        }
    }
    
}
















