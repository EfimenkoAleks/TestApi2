//
//  PreviewViewController.swift
//  TestApi
//
//  Created by mac on 14.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire

class PreviewViewController: UIViewController , UIGestureRecognizerDelegate {
    
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var viewDrag: UIView!
    @IBOutlet weak var viewPinch: UIView!
    @IBOutlet var viewTap: UIView!
    
    var photo : PhotoCollection!
    private var photoBig : String!
    private var imageRefreh : UIImage!
    private var pinchGesture  = UIPinchGestureRecognizer()
    private var panGesture  = UIPanGestureRecognizer()
    private var tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(PreviewViewController.pinchedView))
        viewPinch.isUserInteractionEnabled = true
        viewPinch.addGestureRecognizer(pinchGesture)
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(PreviewViewController.draggedView(_:)))
        viewDrag.isUserInteractionEnabled = true
        viewDrag.addGestureRecognizer(panGesture)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(PreviewViewController.myviewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        viewTap.addGestureRecognizer(tapGesture)
        viewTap.isUserInteractionEnabled = true
        
        self.photoBig = self.photo.photoImageUrlBig
        self.downloadPhotoImage()
    }
    
    func downloadPhotoImage() {
        request(self.photoBig).responseData { (response) in
            if let data = response.result.value {
                if let images = UIImage(data: data) {
                    self.previewImage.image = images
                    self.imageRefreh = images
                }
            }
            
        }
        
    }
    
    @objc func pinchedView(sender:UIPinchGestureRecognizer){
        self.view.bringSubview(toFront: viewPinch)
        sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubview(toFront: viewDrag)
        let translation = sender.translation(in: self.view)
        viewDrag.center = CGPoint(x: viewDrag.center.x + translation.x, y: viewDrag.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @objc func myviewTapped(_ sender: UITapGestureRecognizer) {
        
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
    }
    
    
    
}
