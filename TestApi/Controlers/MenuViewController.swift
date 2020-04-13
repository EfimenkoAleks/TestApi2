//
//  MenuViewController.swift
//  TestApi
//
//  Created by mac on 7/29/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    private var arrayCollection = ["Wallpapers", "Textures & Patterns", "Nature", "Current Events", "Architecture", "Business & Work", "Film", "Animals", "Travel", "Fashion", "Food & Drink", "Spirituality", "Experimental"]
    
    var menuTable: UITableView?
    let cellId = "menu"
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addTable()
        menuTable?.register(MenuCell.self, forCellReuseIdentifier: cellId)
        
        view.backgroundColor = HelperMetods.shared.hexStringToUIColor(hex: "#74b9ff")
        
        navigationController?.navigationBar.shadowImage = UIImage()
        //       navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        title = "Create your collection"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.menuTable!.reloadData()
    }
    
    private func addTable() {
        menuTable = UITableView()
        menuTable!.dataSource = self
        menuTable!.delegate = self
        menuTable!.separatorStyle = .none
        menuTable!.backgroundColor = UIColor.clear
        menuTable?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(menuTable!)
        
        menuTable?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuTable?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        menuTable?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        menuTable?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DataServisForControls.instanceControl.photoCollection.removeAll()
        LOAD_PAGE = 1
        DataServisForControls.instanceControl.choisePhotos.removeAll()
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu") as! MenuCell
        
        cell.nameLabel.text = arrayCollection[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        QUERY = self.arrayCollection[indexPath.row]//.lowercased()
        AppDelegate.shared.rootViewController.switchPhoto(text: QUERY)
        isLoading = true
        //       print("\(QUERY)")
    }
    
    //    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    //        let alert = UIAlertController(title: self.masivCarStr[indexPath.row].dateOfBirth, message: self.masivCarStr[indexPath.row].propertyCar, preferredStyle: UIAlertController.Style.alert)
    //        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
    //
    //        alert.addAction(cancelAction)
    //        present(alert, animated: true, completion: nil)
    //    }
    
    
    
}

extension MenuViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Enter cliked")
        let text = HelperMetods.shared.urlWithSearchText(searchText: self.searchController.searchBar.text!)
        QUERY = text//.lowercased()
        AppDelegate.shared.rootViewController.showPhoto(text: QUERY)
        isLoading = true
    }
}



