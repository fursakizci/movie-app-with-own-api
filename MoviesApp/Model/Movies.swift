//
//  Movies.swift
//  MoviesApp
//
//  Created by Furkan sakızcı on 18.07.2020.
//  Copyright © 2020 Furkan sakızcı. All rights reserved.
//

import Foundation

class Movies:Codable{
    var movie_id:String?
    var name:String?
    var year:String?
    var poster:String?
    var categories:Categories?
    var directors:Directors?
}
