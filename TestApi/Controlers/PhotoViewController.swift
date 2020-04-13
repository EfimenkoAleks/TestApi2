//
//  PhotoViewController.swift
//  TestApi
//
//  Created by mac on 16.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

//

import UIKit

class PhotoViewController: UIViewController {
    
    var photocollection: UICollectionView?
    let cellId = "Photo"
    var text = ""
    
    private var refreshControl : UIRefreshControl!
    
    init(textName: String) {
        super.init(nibName: nil, bundle: nil)
        self.text = textName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addCollecton()
        photocollection?.register(PhotoCell.self, forCellWithReuseIdentifier: cellId)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        //        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        view.backgroundColor = HelperMetods.shared.hexStringToUIColor(hex: "#74b9ff")
        title = text
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(reloadData), for: UIControl.Event.valueChanged)
        photocollection!.insertSubview(self.refreshControl, at: 0)
        
        print("\(DataServisForControls.instanceControl.photoCollection.count)")
        
        let imageBack = UIImage(named: "back")
        let imageTempBack = imageBack?.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageTempBack, style: .plain, target: self, action: #selector(PhotoViewController.backButton))
        
        if isLoading {
            self.loadingObject()
        }
        
    }
    
    @objc func backButton() {
        AppDelegate.shared.rootViewController.switchToMenu()
        gIndexForCollection = 1
    }
    
    private func addCollecton() {
        
        //        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //
        //        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        //        layout.minimumInteritemSpacing = 2
        //        layout.minimumLineSpacing = 2
        //
        //        layout.itemSize = CGSize(width: (self.view.bounds.width / 2) - 4, height: self.view.bounds.height * 0.18 - 4)
        let layout = PinterestLayout()
        layout.delegate = self
        
        photocollection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        photocollection!.dataSource = self
        photocollection!.delegate = self
        
        photocollection!.backgroundColor = UIColor.clear
        photocollection?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(photocollection!)
        
        photocollection?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height / 8).isActive = true
        photocollection?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        photocollection?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        photocollection?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isResponse = true
    }
    
    @objc func reloadData () {
        
        DataServisForControls.instanceControl.downloadTopPhotoCollection {
            print("reloadData \(DataServisForControls.instanceControl.photoCollection.count)")
            
            for photo in DataServisForControls.instanceControl.photoCollection {
                photo.photoCoefHeight = self.paymentAspectRatio(photo: photo)
                photo.downloadPhotoImage(completed: {
                    
                    self.photocollection!.reloadData()
                    self.refreshControl.endRefreshing()
                })
                
            }
        }
    }
    
    func searchColection() {
        
        let que = HelperMetods.shared.urlWithSearchText(searchText: QUERY)
        QUERY = que
    }
    
    func loadingObject() {
        
        searchColection()
        reloadData()
    }
    
    // для расчета высоты фото
    
    func paymentAspectRatio(photo: Photo) -> CGFloat {
        
        let constWidth = self.view.frame.width / 2 - 6
        
        let coefHeight = photo.photoHeight * constWidth / photo.photoWidth
        
        return coefHeight
    }
    
    // переход на другой контролер
    
    //    private func goToNextController(photo: PhotoCollection) {
    //
    //        let secondVC = PreviewViewController(photo: photo)
    //        secondVC.modalPresentationStyle = .overCurrentContext
    //        secondVC.modalTransitionStyle = .crossDissolve
    //        present(secondVC, animated: true, completion: nil)
    //    }
    
}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching, UICollectionViewDelegateFlowLayout {
    
    //    MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataServisForControls.instanceControl.photoCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo", for: indexPath) as? PhotoCell {
            
            let photo = DataServisForControls.instanceControl.photoCollection[indexPath.row].photoImage
            
            cell.configureCell(photo)
            
            return cell
        } else {
            return  PhotoCell()
        }
    }
    
    //    MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//        let model = yourmodels[indexPath.row]
//        yourfetchClass.fetch(model.id)
//        }
    }
    
    //    MARK: - UICollectionViewDelegateFlowLayout
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //
    //        let photo = DataServisForControls.instanceControl.photoCollection[indexPath.row]
    //
    //        var heightImage: CGFloat = 200
    //        if let heightInPoints = photo.photoImage?.size.height {
    //            heightImage = heightInPoints
    //        }
    //
    //
    //        let width: CGFloat = photocollection!.bounds.width / 2 - 4 //(photocollection!.bounds.width / 2) - 15
    //        let height: CGFloat = heightImage //width * (4 / 3)
    //        print("\(height)")
    //        return CGSize(width: width, height: height)
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //
    //        let inset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    //
    //        return inset
    
    //-------------------------------------------------------------------------------------
    // для ращета картинок с разной высотой , ширина одинакова , и item одинаковы
    
    //private var itemsPerRow: CGFloat = 2
    //private var sectionInsets = UIEdgeInsets(top: 20, left: 20, botom: 20, right: 20)
    
    //collectionView.layoutMatgins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    //collectionView.contentInsetAdjustmentBehavior = .automatic
    
//    let photo = photos[indexPath.item]
//    let paddingSpace = sectionInserts.left * (itemdPerRow + 1)
//    let availableWidth = view.frame.width - paddingSpace
//    let widthPerItem = availableWidth / itemsPerRow
//    let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
//    return CGSize(width: widthPerItem, height: height)
    
    //in insertForSectionAt :
    //retutn sectionInsets
    
    //in minimumLineSpacingForSectionAt :
    //return sectionInserts.left
     //-------------------------------------------------------------------------------------
    //    }
    
    
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 2
    //    }
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = DataServisForControls.instanceControl.photoCollection[indexPath.item]
        gIndexForCollection = indexPath.item
        
        var choiceBool = true
        let choicePhoto = ChoicePhoto()
        choicePhoto.image = photo.photoImage
        choicePhoto.imageBig = photo.photoImageUrlBig
        choicePhoto.title = photo.photoTitl
        
        if DataServisForControls.instanceControl.choisePhotos.count > 0 {
            for choice in DataServisForControls.instanceControl.choisePhotos {
                if choice.imageBig == choicePhoto.imageBig {
                    choiceBool = false
                }
            }
            if choiceBool {
                DataServisForControls.instanceControl.choisePhotos.insert(choicePhoto, at: 0)
            }
        } else {
            DataServisForControls.instanceControl.choisePhotos.insert(choicePhoto, at: 0)
        }
        
        guard let cell = self.photocollection!.cellForItem(at: indexPath) as? PhotoCell else { return }
        
        let cardViewFrame = cell.imageView.superview?.convert(cell.imageView.frame, to: nil)
        let copiOfCardView = UIImageView(frame: cardViewFrame!)
        copiOfCardView.layer.cornerRadius = 12.0
        view.addSubview(copiOfCardView)
        copiOfCardView.image = photo.photoImage
        
        UIView.animate(withDuration: 0.4, animations: {
            copiOfCardView.layer.cornerRadius = 0.0
            copiOfCardView.frame = self.view.frame
        }) { (extended) in
            AppDelegate.shared.rootViewController.showPreview()
        }
        
        
        
        //        let force: CGFloat = 0.8
        //        let scale = CGAffineTransform(scaleX: 1 * force, y: 1 * force)
        //        copiOfCardView.transform = scale
        //
        //        UIView.animate(withDuration: 1.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
        //
        //            let rotation = CGAffineTransform(rotationAngle: 0.3)
        //            copiOfCardView.transform = rotation
        //
        //        }) { (finished) in
        //            if finished {
        //                copiOfCardView.removeFromSuperview()
        //             //   AppDelegate.shared.rootViewController.showPreview(photo: photo)
        //                AppDelegate.shared.rootViewController.switchPreview(photo: photo)
        //            }
        //        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if gWillDisplay {
            self.photocollection?.scrollToItem(at: IndexPath(item: gIndexForCollection, section: 0), at: .top, animated: false)
            gWillDisplay = false
        }
        // после какого item    начнётся загрузка следующих item
        if indexPath.item == (DataServisForControls.instanceControl.photoCollection.count - 10) && isResponse == true {
            LOAD_PAGE = LOAD_PAGE + 1
            self.reloadData()
            print("willDisplay \(LOAD_PAGE)")
        }
    }
    
}

//MARK: Extention PinterestLayout - расширение для нестандартных рамок

extension PhotoViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        
        return DataServisForControls.instanceControl.photoCollection[indexPath.row].photoCoefHeight!
        
    }
}
