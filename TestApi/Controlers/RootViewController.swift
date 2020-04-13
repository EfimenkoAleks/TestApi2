//
//  RootViewController.swift
//  TestApi
//
//  Created by mac on 7/29/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var current: UIViewController
    
    init() {
        current = UINavigationController(rootViewController: MenuViewController())
        super.init(nibName:  nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    func showPhoto(text: String) {
        
        let new = UINavigationController(rootViewController: PhotoViewController(textName: text))
        
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        
        current = new
    }
    
    func showPreview() {
        
        let new = UINavigationController(rootViewController: PageViewController())
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    
    //    func switchPreview(photo: ChoicePhoto) {
    //
    //        let previewViewController = PreviewViewController(photo: photo)
    //        let previewScreen = UINavigationController(rootViewController: previewViewController)
    //        animateFadeTransition(to: previewScreen)
    //
    //    }
    
    func switchPhoto(text: String) {
        
        let photoViewController = PhotoViewController(textName: text)
        let photoScreen = UINavigationController(rootViewController: photoViewController)
        animateFadeTransition(to: photoScreen)
        
    }
    
    func switchToMenu() {
        let menuViewController = MenuViewController()
        let menuScreen = UINavigationController(rootViewController: menuViewController)
        animateDismissTransition(to: menuScreen)
    }
    
    func switchToPhoto(text: String) {
        let photoViewController = PhotoViewController(textName: text)
        let photoScreen = UINavigationController(rootViewController: photoViewController)
        animateDismissTransition(to: photoScreen)
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
            
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        
        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        new.view.frame = initialFrame
        
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
}
