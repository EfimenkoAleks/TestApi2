//
//  PhotoViewController.swift
//  TestApi
//
//  Created by mac on 16.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var refreshControl : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoCollection.delegate = self
        photoCollection.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotoViewController.reloadData), for: UIControlEvents.valueChanged)
        photoCollection.insertSubview(refreshControl, at: 0)
        
        reloadData()
    }
    
    @objc func reloadData () {
        DataServis.instance.downloadTopPhoto {
            for photo in DataServis.instance.photo {
                photo.downloadPhotoImage (completed: {
                    self.photoCollection.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                })
            }
        }
    }

    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataServis.instance.photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExplorePhotoCellCollectionViewCell", for: indexPath) as? ExplorePhotoCellCollectionViewCell {
            
            let photo = DataServis.instance.photo[indexPath.row]
            cell.configureCell(photo)
            
            return cell
        } else {
            return  ExplorePhotoCellCollectionViewCell()
        }
        //cell.imageView.image = UIImage(named: "notFound")
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (photoCollection.bounds.width / 2) - 15
        let height = width * (4 / 3)
        
        return CGSize(width: width, height: height)
    }
    
    
    
}
