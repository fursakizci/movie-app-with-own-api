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
        
        let request = URL(string: "http://fursakizci.tk/movies/all_categories.php")!
        
        URLSession.shared.dataTask(with: request){(data,response,error) in
            
            if error != nil || data == nil{
                print("Error")
            }
            guard let data = data else {return}
            
            do{
                 let result = try JSONDecoder().decode(CategoryResult.self, from: data)
                
                if let resultCategory = result.categories{
                    self.categories = resultCategory
                }
                DispatchQueue.main.async {
                    self.categoryTableView.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
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
