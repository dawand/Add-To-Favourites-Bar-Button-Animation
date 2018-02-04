//
//  FavouritesTableViewController.swift
//  AddToFavouritesBarButtonItem
//
//  Created by Dawand Sulaiman on 02/02/2018.
//  Copyright © 2018 Kurdcode. All rights reserved.
//

import UIKit

class FavouritesTableViewController: UITableViewController {

    var favs = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favs = UserDefaults.standard.array(forKey:"favourites") as! [String]
        print(favs)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath)

        let symbol = favs[indexPath.row]
        
        cell.textLabel?.text = cryptoSymbolNames[symbol]
        cell.detailTextLabel?.text = symbol
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let deleteFav = favs[indexPath.row]
            
            let newFavs = favs.filter {$0 != deleteFav}
            UserDefaults.standard.set(newFavs, forKey: "favourites")
            
            favs.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFavDetail" {
            let detailView = segue.destination as! DetailViewController
            
            if let selectedIndex = tableView.indexPathForSelectedRow {
                detailView.detailItem = favs[selectedIndex.row]
            }
        }
    }
}
