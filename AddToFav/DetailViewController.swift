//
//  DetailViewController.swift
//  AddToFavouritesBarButtonItem
//
//  Created by Dawand Sulaiman on 04/02/2018.
//  Copyright © 2018 Kurdcode. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var cryptoDetailLabel: UILabel!
    
    var rightIconButton: UIButton!

    var isFavourite: Bool = false

    var detailItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup the right bar button custom view
        let icon = UIImage(named: "star")?.withRenderingMode(.alwaysOriginal)
        let iconSize = CGRect(origin: CGPoint.zero, size: icon!.size)
        rightIconButton = UIButton(frame: iconSize)
        rightIconButton.setBackgroundImage(icon, for: .normal)
        
        rightBarButton.customView = rightIconButton
        
        rightIconButton.addTarget(self, action: #selector(addToFavourites), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        setCryptoDetails()
        checkFavourite()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setCryptoDetails() {
        if let item = detailItem {
            self.cryptoDetailLabel.text = cryptoSymbolNames[item]
        }
    }
    
    func checkFavourite(){
        
        let favs = UserDefaults.standard.array(forKey:"favourites") as? [String] ?? [String]()
        
//        print(favs)
        
        // At least 1 favorite
        if favs.count != 0 {
            
            favs.forEach {
                
                if $0 == detailItem {
                    print("already in favourites!")
                    
                    // perform an animation and set isfav to true
                    rightBarButton.customView!.transform = CGAffineTransform(scaleX: 0, y: 0)
                    
                    UIView.animate(withDuration: 0.5,
                                   delay: 0.25,
                                   usingSpringWithDamping: 0.5,
                                   initialSpringVelocity: 10,
                                   options: .curveEaseIn,
                                   animations: {
                                    
                                    let imageFav : UIImage = UIImage(named: "star-filled")!.withRenderingMode(.alwaysOriginal)   // Set the image
                                    self.rightIconButton.setBackgroundImage(imageFav, for: .normal)
                                    
                                    self.isFavourite = true                            // set isFavourite true
                                    
                                    self.rightBarButton.customView!.transform = CGAffineTransform.identity
                                    }, completion: nil
                    )
                }
            }
        }
    }
    
    @objc func addToFavourites() {
        // Add current quote to the favorites, only if is not already present
        
        guard let favWord = detailItem else {
            print("no word to add ore remove")
            return
        }
        
        // get the old favs list
        var favs = UserDefaults.standard.array(forKey:"favourites") as? [String] ?? [String]()

        // if the item is not in fav list
        if isFavourite == false {
            
            // append the new item
            favs.append(favWord)
            
            // save the new fav list
            UserDefaults.standard.set(favs, forKey: "favourites")
            UserDefaults.standard.synchronize()
            
            // do the add to fav animation
            rightBarButton.customView!.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 6/5))
            
            UIView.animate(withDuration: 1.0) {
                let imageFav : UIImage = UIImage(named: "star-filled")!.withRenderingMode(.alwaysOriginal)   // Set the image
                self.rightIconButton.setBackgroundImage(imageFav, for: .normal)
                self.isFavourite = true                               // Now is a favorite
                self.rightBarButton.customView!.transform = CGAffineTransform.identity
            }
         
            // if the item is already fav'ed
        } else {
            
            if let index = favs.index(of: favWord) {
                // remove the item
                favs.remove(at: index)
                
                // save the new fav list
                UserDefaults.standard.set(favs, forKey: "favourites")
                UserDefaults.standard.synchronize()
                
                // wind back to original position
                rightBarButton.customView!.transform = CGAffineTransform(rotationAngle: 0 - CGFloat(Double.pi * 6/5))
                
                // animate back to original position
                UIView.animate(withDuration: 1.0) {
                    let imageFav : UIImage = UIImage(named: "star")!.withRenderingMode(.alwaysOriginal)  // Set the Image
                    self.rightIconButton.setBackgroundImage(imageFav, for: .normal)    // Change the Image
                    self.isFavourite = false                           // Set isFavourite false
                    self.rightBarButton.customView!.transform = CGAffineTransform.identity
                }
            }
        }
    }
}
