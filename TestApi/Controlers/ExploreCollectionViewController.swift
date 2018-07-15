//
//  ExploreCollectionViewController.swift
//  TestApi
//
//  Created by mac on 13.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire

class ExploreCollectionViewController: UICollectionViewController {

    @IBOutlet weak var collectionPhoto: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    let leftAndRightPaddings: CGFloat = 32.0
    let numberOfItemsPerRow: CGFloat = 3.0
    let heightAdjustment: CGFloat = 30.0
    
    struct Storybord {
        static let explorePhotoSell = "ExplorePhotoCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //configure the collection view
        self.collectionView?.backgroundColor = UIColor.white
        var width : CGFloat = 0.0
        width = (self.collectionView!.frame.size.width - leftAndRightPaddings) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize.init(width: width, height: width + heightAdjustment)
        
        DataServis.instance.downloadTopPhoto {
            for photo in DataServis.instance.photo {
                photo.downloadPhotoImage {
                    self.collectionPhoto.reloadData()
                }
            }
        }
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storybord.explorePhotoSell, for: indexPath) as? ExplorePhotoCellCollectionViewCell {
            
            
            return cell
        } else {
            return  ExplorePhotoCellCollectionViewCell()
        }
    //cell.imageView.image = UIImage(named: "notFound")
    }
   
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
