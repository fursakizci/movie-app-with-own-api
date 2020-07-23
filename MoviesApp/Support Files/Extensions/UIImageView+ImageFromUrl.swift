//
//  UIImageView+ImageFromUrl.swift
//  MoviesApp
//
//  Created by Furkan sakızcı on 24.07.2020.
//  Copyright © 2020 Furkan sakızcı. All rights reserved.
//

import UIKit

extension UIImageView{
    func getImage(withText text:String){
           if let url = URL(string: "http://fursakizci.tk/movies/Posters/\(text)"){

             let request = URLRequest(url: url)

             let task = URLSession.shared.dataTask(with: request) {(data,response,error) in
                
                if error != nil || data == nil{
                    print("Error")
                }else{
                    guard let data = data else{return}
                    DispatchQueue.main.sync {
                        self.image = UIImage(data: data)
                    }
                }
           }
              task.resume()
        }
    }
}

