//
//  PreviewViewController.swift
//  TestApi
//
//  Created by mac on 14.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire
import CoreImage

class PreviewViewController: UIViewController {
    
    var smalImage: UIImageView = {
        let imageView1 = UIImageView()
        imageView1.image = UIImage(named: "picture")
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        imageView1.layer.shadowOffset = CGSize(width: 4, height: 4)
        imageView1.layer.shadowOpacity = 0.7
        imageView1.layer.shadowRadius = 4
        //       imageView1.layer.masksToBounds = true
        imageView1.contentMode = .scaleAspectFit
        imageView1.backgroundColor = .clear
        
        return imageView1
    }()
    
    let loadIndikator : UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView(style: .whiteLarge)
        ind.backgroundColor = .lightGray
        ind.alpha = 0.5
        ind.translatesAutoresizingMaskIntoConstraints = false
        
        return ind
    }()
    
    var indexVc: Int?
    var photo : ChoicePhoto!
    var viewScroll: ImageScrollView!
    //    var items = [UIBarButtonItem]()
    
    init(photo: ChoicePhoto, index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.photo = photo
        self.indexVc = index
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSmalImage()
        
        self.smalImage.image = photo.image
        self.loadIndikator.startAnimating()
        self.view.backgroundColor = HelperMetods.shared.hexStringToUIColor(hex: "#8395a7")
        self.title = photo.title
        
        navigationController?.navigationBar.shadowImage = UIImage()
        //       navigationController?.navigationBar.tintColor = .black
        //      navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        //        self.setupNavigationBarButton()
        
        //        self.createToolBar()
        guard self.photo.imageBig != nil else { return }
        
        if let big = self.photo.imageBig {
            
            DataServisForControls.instanceControl.downloadImageBig(url: big) { (image) in
                
                self.viewScroll = ImageScrollView(frame: self.view.bounds)
                self.view.addSubview(self.viewScroll)
                self.addViewScroll()
                
                self.viewScroll.set(image: image!)
                
                self.loadIndikator.stopAnimating()
                self.smalImage.removeFromSuperview()
                self.loadIndikator.removeFromSuperview()
                self.setupEffect()
            }
        }
        
    }
    
    private func addViewScroll() {
        
        viewScroll.translatesAutoresizingMaskIntoConstraints = false
        viewScroll.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        viewScroll.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        viewScroll.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        viewScroll.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func addSmalImage() {
        
        self.view.addSubview(smalImage)
        
        smalImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width / 5).isActive = true
        smalImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.height / 4).isActive = true
        smalImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -(self.view.bounds.width / 5)).isActive = true
        smalImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.bounds.height / 4)).isActive = true
        smalImage.heightAnchor.constraint(equalToConstant: self.view.frame.height - (self.view.bounds.height / 2)).isActive = true
        smalImage.widthAnchor.constraint(equalToConstant: self.view.frame.width - ((self.view.bounds.width / 5)) * 2).isActive = true
        
        self.smalImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 15)
        
        self.setupLoadIndikator()
        
    }
    
    private func setupLoadIndikator() {
        
        self.view.addSubview(loadIndikator)
        
        loadIndikator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        loadIndikator.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        loadIndikator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        loadIndikator.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    //    func rotateAnimation(imageView:UIImageView,duration: CFTimeInterval = 1) {
    //        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
    //        rotateAnimation.fromValue = 0.0
    //        rotateAnimation.toValue = CGFloat(.pi * 0.5)
    //        rotateAnimation.duration = duration
    //   //     rotateAnimation.repeatCount = Float.greatestFiniteMagnitude;
    //
    //        imageView.layer.add(rotateAnimation, forKey: nil)
    //    }
    
    
    
    
    //    @objc func save() {
    //
    //        if self.previewImage.image != nil {
    //        let alert = UIAlertController(title: "Name", message: "Enter name", preferredStyle: UIAlertController.Style.alert)
    //
    //        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default) { (action) in
    //
    //             let image = self.previewImage.image
    //            DispatchQueue.global(qos: .background).async {
    //                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    //            }
    //
    //        }
    //        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
    //
    //        alert.addAction(saveAction)
    //        alert.addAction(cancelAction)
    //        present(alert, animated: true, completion: nil)
    //    }
    //    }
    
    //    private func setButton() {
    //        let button =  UIButton(type: .custom)
    //        button.setImage(UIImage(named: "filter1"), for: .normal)
    //        button.frame = CGRect(x: self.view.bounds.width - self.view.bounds.width / 6, y: self.view.bounds.height - self.view.bounds.height + self.view.bounds.height / 8, width: 40, height: 40)
    //        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    //        button.backgroundColor = UIColor.clear
    //        button.layer.cornerRadius = 20.0
    //        self.view.addSubview(button)
    //
    //    }
    
    func setupEffect() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(PreviewViewController.sepiaEffect), name: NSNotification.Name(rawValue: DataServisForControls.instanceControl.choisePhotos[self.indexVc!].imageBig! + "sepiaEffect"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PreviewViewController.noirEffect), name: NSNotification.Name(rawValue: DataServisForControls.instanceControl.choisePhotos[self.indexVc!].imageBig! + "noirEffect"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PreviewViewController.bloomEffect), name: NSNotification.Name(rawValue: DataServisForControls.instanceControl.choisePhotos[self.indexVc!].imageBig! + "bloomEffect"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PreviewViewController.procesEffect), name: NSNotification.Name(rawValue: DataServisForControls.instanceControl.choisePhotos[self.indexVc!].imageBig! + "procesEffect"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PreviewViewController.refreshFilters), name: NSNotification.Name(rawValue: DataServisForControls.instanceControl.choisePhotos[self.indexVc!].imageBig! + "refreshFilters"), object: nil)
    }
    
    @objc private func sepiaEffect() {
        
        guard let image = viewScroll.imageZoomView.image else {
            return
        }
        self.setupLoadIndikator()
        self.loadIndikator.startAnimating()
        DispatchQueue.global(qos: .utility).async {
            let imageQueue = HelperMetods.shared.applyFilters(image: image, filterEffectName: "CISepiaTone", filterEffectValue: 0.7, filterEffectValueName: kCIInputIntensityKey)
            DispatchQueue.main.async {
                self.viewScroll.set(image: imageQueue!)
                self.loadIndikator.stopAnimating()
                self.loadIndikator.removeFromSuperview()
            }
        }
    }
    
    @objc private func noirEffect() {
        
        guard let image = viewScroll.imageZoomView.image else {
            return
        }
        self.setupLoadIndikator()
        self.loadIndikator.startAnimating()
        DispatchQueue.global(qos: .utility).async {
            let imageQueue = HelperMetods.shared.applyFilters(image: image, filterEffectName: "CIPhotoEffectNoir", filterEffectValue: nil, filterEffectValueName: nil)
            DispatchQueue.main.async {
                self.viewScroll.set(image: imageQueue!)
                self.loadIndikator.stopAnimating()
                self.loadIndikator.removeFromSuperview()
            }
        }
    }
    
    @objc private func bloomEffect() {
        
        guard let image = viewScroll.imageZoomView.image else {
            return
        }
        self.setupLoadIndikator()
        self.loadIndikator.startAnimating()
        DispatchQueue.global(qos: .utility).async {
            let imageQueue = HelperMetods.shared.applyFilters(image: image, filterEffectName: "CIBloom", filterEffectValue: 2, filterEffectValueName: kCIInputIntensityKey)
            DispatchQueue.main.async {
                self.viewScroll.set(image: imageQueue!)
                self.loadIndikator.stopAnimating()
                self.loadIndikator.removeFromSuperview()
            }
        }
    }
    
    @objc private func procesEffect() {
        
        guard let image = viewScroll.imageZoomView.image else {
            return
        }
        self.setupLoadIndikator()
        self.loadIndikator.startAnimating()
        DispatchQueue.global(qos: .utility).async {
            let imageQueue = HelperMetods.shared.applyFilters(image: image, filterEffectName: "CIPhotoEffectProcess", filterEffectValue: nil, filterEffectValueName: nil)
            DispatchQueue.main.async {
                self.viewScroll.set(image: imageQueue!)
                self.loadIndikator.stopAnimating()
                self.loadIndikator.removeFromSuperview()
            }
        }
    }
    
    @objc private func refreshFilters() {
        
        guard self.viewScroll.imageZoomView.image != nil else {
            return
        }
        self.setupLoadIndikator()
        self.loadIndikator.startAnimating()
        DataServisForControls.instanceControl.downloadImageBig(url: self.photo.imageBig!) { (image) in
            self.viewScroll.set(image: image!)
            self.loadIndikator.stopAnimating()
            self.loadIndikator.removeFromSuperview()
        }
    }
    
    
    
}

//extension PreviewViewController: UIPopoverPresentationControllerDelegate {
//    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//        return .none
//    }
//
//}


