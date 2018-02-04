//
//  ViewController.swift
//  AddToFavouritesBarButtonItem
//
//  Created by Dawand Sulaiman on 02/02/2018.
//  Copyright © 2018 Kurdcode. All rights reserved.
//

import UIKit

let cryptoSymbolNames: [String:String] = ["BTC":"Bitcoin",
                                          "ETH":"Ethereum",
                                          "XRP":"Ripple",
                                          "BCH":"Bitcoin Cash",
                                          "ADA":"Cardano",
                                          "LTC":"Litcoin",
                                          "XLM":"Stellar",
                                          "NEO":"NEO",
                                          "XEM":"NEM",
                                          "MIOTA":"IOTA"]

class WordsViewController: UITableViewController {

    let cryptoSymbols = Array(cryptoSymbolNames.keys)
    
    var detailViewController: DetailViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
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
        return cryptoSymbolNames.keys.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath)
        
        let symbol = cryptoSymbols[indexPath.row]
        
        cell.textLabel?.text = cryptoSymbolNames[symbol]
        cell.detailTextLabel?.text = symbol
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showCryptoDetail" {
             if let indexPath = tableView.indexPathForSelectedRow {
            let detailView = segue.destination as! DetailViewController
            
                detailView.detailItem = cryptoSymbols[indexPath.row]
            }
        }
    }
}

