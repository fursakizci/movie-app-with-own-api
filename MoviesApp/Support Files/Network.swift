//
//  Network.swift
//  MoviesApp
//
//  Created by Furkan sakızcı on 24.07.2020.
//  Copyright © 2020 Furkan sakızcı. All rights reserved.
//

import Foundation

class Network{
    
    static func request<T:Decodable>(_ request:URLRequest,completion: @escaping (T?,Error?) -> Void ){
       
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            if let error = error{
                print(error.localizedDescription)
            }
            guard let data = data else{return}
            
            do{
                let decodable = try JSONDecoder().decode(T.self, from: data)
                completion(decodable,nil)
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    static func movies(category_id:Int,completion:@escaping (MovieResult? , Error?) ->Void){
        var url = URLRequest(url:URL(string:"http://fursakizci.tk/movies/movies_by_category_id.php")!)
        url.httpMethod = "POST"
        let postString = "category_id=\(category_id)"
        url.httpBody = postString.data(using: .utf8)
        
        request(url, completion: completion)
    }
    
    static func category(completion: @escaping (CategoryResult? , Error?) -> Void){
        let url = URLRequest(url:URL(string: "http://fursakizci.tk/movies/all_categories.php")!)
        
        request(url, completion: completion)
    }
}
