//
//  PhotoViewController.swift
//  TestApi
//
//  Created by mac on 16.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var refreshControl : UIRefreshControl!
    private var forIndex = 0
    private var arraysubject : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let keyReset = 0
        UserDefaults.standard.set(keyReset, forKey: "key")
        UserDefaults.standard.synchronize()
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        photoCollection.delegate = self
        photoCollection.dataSource = self
    
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.arraysubject = ["apple","Black & White","Fog","Houseplant","Water Drop","Adventure","ROAD","Beautiful","Yellow","music"]
        searchColection()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotoViewController.reloadData), for: UIControlEvents.valueChanged)
        photoCollection.insertSubview(refreshControl, at: 0)
        
        reloadData()
    }        
    
    @IBAction func rightItem(_ sender: UIBarButtonItem) {
        
        var key = UserDefaults.standard.integer(forKey: "key")
        if key < self.arraysubject.count - 1 {
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            key = key + 1
            let stringForKey = self.arraysubject[key]
            QUERY = stringForKey
            UserDefaults.standard.set(key, forKey: "key")
            UserDefaults.standard.synchronize()
            LOAD_PAGE = 1
            self.photoCollection.reloadData()
            loadingObject()
        }
        if key == self.arraysubject.count - 1 {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @IBAction func leftItem(_ sender: UIBarButtonItem) {
        
        var key = UserDefaults.standard.integer(forKey: "key")
        if key > 0 {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            key = key - 1
            let stringForKey = self.arraysubject[key]
            QUERY = stringForKey
            UserDefaults.standard.set(key, forKey: "key")
            UserDefaults.standard.synchronize()
            LOAD_PAGE = 1
            self.photoCollection.reloadData()
            loadingObject()
        }
        if key < 1 {
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        }
    }
    
    @objc func reloadData () {
        DataServisForControls.instanceControl.downloadTopPhotoCollection {
            for photo in DataServisForControls.instanceControl.photoCollection {
                photo.downloadPhotoImage(completed: {
                    self.photoCollection.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                })
            }
        }
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataServisForControls.instanceControl.photoCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExplorePhotoCellCollectionViewCell", for: indexPath) as? ExplorePhotoCellCollectionViewCell {
            let photo = DataServisForControls.instanceControl.photoCollection[indexPath.row]
            cell.configureCell(photo)
            
            return cell
        } else {
            return  ExplorePhotoCellCollectionViewCell()
        }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (photoCollection.bounds.width / 2) - 15
        let height = width * (4 / 3)
        return CGSize(width: width, height: height)
    }
    
    //MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let previewController = segue.destination as! PreviewViewController
            previewController.photo = DataServisForControls.instanceControl.photoCollection[forIndex]
        }
    }
    
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        forIndex = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == (DataServisForControls.instanceControl.photoCollection.count-1) {
            LOAD_PAGE = LOAD_PAGE + 1
            self.reloadData()
        }
    }
    
    //MARK - UISerchBarDelegat
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.isEmpty == false {
            searchBar.resignFirstResponder()
            loadingObject()
        }
    }
    
    //MARK: - Helper metods
    func urlWithSearchText(searchText: String) -> String {
        let escapedSearchText = searchText.replacingOccurrences(of: " ", with: "")
        return escapedSearchText
    }
    
    func searchColection() {
        let key = UserDefaults.standard.integer(forKey: "key")
        if !self.searchBar.text!.isEmpty {
            QUERY = self.urlWithSearchText(searchText: self.searchBar.text!)
            self.searchBar.text = ""
        } else {
            QUERY = self.urlWithSearchText(searchText: arraysubject[key])
        }
    }
    
    func loadingObject() {
        DataServisForControls.instanceControl.photoCollection.removeAll()
        searchColection()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotoViewController.reloadData), for: UIControlEvents.valueChanged)
        photoCollection.insertSubview(refreshControl, at: 0)
        reloadData()
    }
    
}
