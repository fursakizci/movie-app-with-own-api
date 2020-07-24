//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by Furkan sakızcı on 18.07.2020.
//  Copyright © 2020 Furkan sakızcı. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    var category:Categories?
    private var isThereSearch:Bool = false
    
    private var movies = [Movies]()
    private var searchResultMovies = [Movies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
        movieSearchBar.delegate = self
        
        if let category = category{
            guard let c_id = category.category_id else{return}
            if let category_id = Int(c_id){
                moviesByCategoryId(category_id: category_id)
            }
            navigationItem.title = category.category_name
        }
        collectionViewLayout()
    }
    
    func moviesByCategoryId(category_id:Int){

        Network.movies(category_id: category_id) { (movieResult, error) in
            if let resultMovie = movieResult?.movies{
                self.movies = resultMovie
            }
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        }
        }
    
    func collectionViewLayout(){
        
        let design:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let width = self.movieCollectionView.frame.size.width
        
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cellWidth = (width-30)/2
        
        design.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.8)
        
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
        
        movieCollectionView.collectionViewLayout = design
    }
    
   
    
}

extension MovieViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == ""{
            isThereSearch = false
        }else{
            isThereSearch = true
            
            searchResultMovies = movies.filter({(mod) -> Bool in
                 mod.name!.contains(searchText)
            })
            print(searchResultMovies.count)
        }
        movieCollectionView.reloadData()
    }
}


// MARK: - UICollectionViewDelegate
extension MovieViewController:UICollectionViewDelegate{
    
}

//MARK: - UICollectionViewDataSource
extension MovieViewController:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isThereSearch{
            return searchResultMovies.count
        }else{
             return movies.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie = movies[indexPath.row]
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        if isThereSearch {
            cell.movieNameLabel.text = searchResultMovies[indexPath.row].name
            cell.movieYearLabel.text = searchResultMovies[indexPath.row].year
            cell.posterImageView.getImage(withText: searchResultMovies[indexPath.row].poster!)

        }else{
            cell.movieNameLabel.text = movie.name
            cell.movieYearLabel.text = movie.year
            cell.posterImageView.getImage(withText: movie.poster!)
        }
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5

        return cell
    }
}




