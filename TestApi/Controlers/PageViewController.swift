//
//  PageViewController.swift
//  TestApi
//
//  Created by mac on 11/15/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    var pageController: UIPageViewController?
    var curentIndex = 0
    var items = [UIBarButtonItem]()
    
    lazy var arrayPreviewControllers: [PreviewViewController] = {
        var previevVC = [PreviewViewController]()
        var indexPVC = 0
        for previevPhoto in DataServisForControls.instanceControl.choisePhotos {
            previevVC.append(PreviewViewController(photo: previevPhoto, index: indexPVC))
            indexPVC += 1
        }
        return previevVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController!.setViewControllers([arrayPreviewControllers[0]], direction: .forward, animated: true, completion: nil)
        self.view.addSubview(self.pageController!.view)
        
        self.view.backgroundColor = HelperMetods.shared.hexStringToUIColor(hex: "#8395a7")
        self.navigationController?.navigationBar.barTintColor = HelperMetods.shared.hexStringToUIColor(hex: "#74b9ff")
        
        
        self.setupNavigationBarButton()
        self.createToolBar()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        title = DataServisForControls.instanceControl.choisePhotos[self.curentIndex].title
    }
    
    override func viewWillLayoutSubviews() {
        let frame = CGRect(x: 0, y: self.view.bounds.height / 10, width: self.view.frame.width, height: self.view.frame.height - self.view.frame.height / 5.3)
        self.pageController?.view.frame = frame
    }
    
    private func setupNavigationBarButton() {
        
        let imageBack = UIImage(named: "back")
        let imageTempBack = imageBack?.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageTempBack, style: .plain, target: self, action: #selector(PageViewController.backButton))
        
        let imageSave = UIImage(named: "save")
        let imageTempSave = imageSave?.withRenderingMode(.alwaysTemplate)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: imageTempSave, style: .plain, target: self, action: #selector(PageViewController.save))
    }
    
    @objc func backButton() {
        AppDelegate.shared.rootViewController.switchToPhoto(text: QUERY)
        isLoading = false
        gWillDisplay = true
    }
    
    @objc func save() {
        
        if DataServisForControls.instanceControl.choisePhotos[self.curentIndex].image != nil {
            let alert = UIAlertController(title:DataServisForControls.instanceControl.choisePhotos[self.curentIndex].title, message: "Save?", preferredStyle: UIAlertController.Style.alert)
            
            let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default) { (action) in
                
                let image = DataServisForControls.instanceControl.choisePhotos[self.curentIndex].image
                DispatchQueue.global(qos: .background).async {
                    UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                }
                
            }
            let cancelAction = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
            
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func createToolBar() {
        
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.backgroundColor = .clear
        self.navigationController?.toolbar.barTintColor = HelperMetods.shared.hexStringToUIColor(hex: "#74b9ff")
        
        let image = UIImage(named: "visual-effects")
        let imageTemp = image?.withRenderingMode(.alwaysTemplate)
        items.append(UIBarButtonItem(image: imageTemp, style: .plain, target: self, action: #selector(PageViewController.sepiaEffect)))
        
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        
        let image1 = UIImage(named: "visual-effects")
        let imageTemp1 = image1?.withRenderingMode(.alwaysTemplate)
        items.append(UIBarButtonItem(image: imageTemp1, style: .plain, target: self, action: #selector(PageViewController.noirEffect)))
        
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        
        let image2 = UIImage(named: "visual-effects")
        let imageTemp2 = image2?.withRenderingMode(.alwaysTemplate)
        items.append(UIBarButtonItem(image: imageTemp2, style: .plain, target: self, action: #selector(PageViewController.bloomEffect)))
        
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        
        let image3 = UIImage(named: "visual-effects")
        let imageTemp3 = image3?.withRenderingMode(.alwaysTemplate)
        items.append(UIBarButtonItem(image: imageTemp3, style: .plain, target: self, action: #selector(PageViewController.procesEffect)))
        
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        
        let image4 = UIImage(named: "refresh")
        let imageTemp4 = image4?.withRenderingMode(.alwaysTemplate)
        items.append(UIBarButtonItem(image: imageTemp4, style: .plain, target: self, action: #selector(PageViewController.refreshFilters)))
        
        self.toolbarItems = items // this made the difference. setting the items to the controller, not the navigationcontroller
    }
    
    @objc private func sepiaEffect() {
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DataServisForControls.instanceControl.choisePhotos[self.curentIndex].imageBig! + "sepiaEffect"), object: nil)
        
    }
    
    @objc private func noirEffect() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DataServisForControls.instanceControl.choisePhotos[self.curentIndex].imageBig! + "noirEffect"), object: nil)
        
    }
    
    @objc private func bloomEffect() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DataServisForControls.instanceControl.choisePhotos[self.curentIndex].imageBig! + "bloomEffect"), object: nil)
        
    }
    
    @objc private func procesEffect() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DataServisForControls.instanceControl.choisePhotos[self.curentIndex].imageBig! + "procesEffect"), object: nil)
        
    }
    
    @objc private func refreshFilters() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DataServisForControls.instanceControl.choisePhotos[self.curentIndex].imageBig! + "refreshFilters"), object: nil)
        
    }
    
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        guard let viewController = viewController as? PreviewViewController else { return nil }
        
        guard var index = viewController.indexVc else { return nil }
        
        if index > 0 {
            index -= 1
            return arrayPreviewControllers[index]
        }
        
        
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        guard let viewController = viewController as? PreviewViewController else { return nil }
        
        guard var index = viewController.indexVc else { return nil }
        
        if index < arrayPreviewControllers.count - 1 {
            index += 1
            return arrayPreviewControllers[index]
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.arrayPreviewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.curentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers![0] as? PreviewViewController {
                self.curentIndex = currentViewController.indexVc!
                title = DataServisForControls.instanceControl.choisePhotos[self.curentIndex].title
            }
        }
        
    }
}
