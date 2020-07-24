//
//  ViewController.swift
//  MoviesApp
//
//  Created by Furkan sakızcı on 18.07.2020.
//  Copyright © 2020 Furkan sakızcı. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    
    @IBOutlet weak var categoryTableView: UITableView!
    
   private var categories = [Categories]()
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        getAllCategory()
    }
    
    func getAllCategory(){
        Network.category { (categoryResult, error) in
            if let error = error{
                print(error.localizedDescription)
            }
            if let resultCategory = categoryResult?.categories{
                self.categories = resultCategory
            }
            DispatchQueue.main.async {
                self.categoryTableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = sender as? Int
        guard let index = indexPath else{return}
        let toGoVC = segue.destination as! MovieViewController
        toGoVC.category = categories[index]
    }
    
}

//MARK: - UITableViewDelegate
extension CategoryViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "togoMovieList", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
}
//MARK: - UITableViewDataSource
extension CategoryViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        let cell = categoryTableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryLabel.text = category.category_name
        return cell
    }
}
