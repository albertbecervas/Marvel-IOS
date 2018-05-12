//
//  HeroesTableViewController.swift
//  PicturesFromMars
//
//  Created by Albert Becerra Hervás on 01/05/2018.
//  Copyright © 2018 Albert Becerra Hervás. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class HeroesTableViewController: UITableViewController {
    
    @IBOutlet var heroesTableView: UITableView!
    
    //MARK: Properties
    var heroes = [Hero]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHeroes()
        
    }
    
    // MARK: Private Methods
    
    private func getHeroes() {
        
        ApiManager().getHeroesJSON(success: { heroes in
            
            self.addHeroesToList(json: heroes)
            
        }, error: {_ in
            print("Errooooor")
        })
        
    }
    
    private func addHeroesToList(json: JSON) {
        let heroesData = json["data"]["results"].arrayValue
        for hero in heroesData {
            
            self.heroes.append(Hero(id: hero["id"].stringValue,
                                    name: hero["name"].stringValue,
                                    description: hero["description"].stringValue,
                                    imageUrl: hero["thumbnail"]["path"].stringValue))
            
        }
        
        self.heroesTableView.reloadData()
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heroes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "HeroesTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HeroesTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let hero = heroes[indexPath.row]
        
        /*if hero.imageUrl != "" {
            
            let imgURL = URL(string: hero.imageUrl + "/landscape_small.jpg")!
            
            cell.heroImage.af_setImage(withURL: imgURL, placeholderImage: #imageLiteral(resourceName: "defMarvel"))
        } else {
            cell.heroImage.image = #imageLiteral(resourceName: "defMarvel")
        }*/
        
        cell.heroName.text = hero.name
        
        
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "heroDetail" {
//            let heroDetailVC = segue.destination as! HeroDetailViewController
//            
//            let selectedIndex = self.heroesTableView.indexPathsForSelectedRows?.first?.row
//            let hero = heroes[selectedIndex!]
//            
//            heroDetailVC.hero = hero
            
        }
    }
    
    
}
