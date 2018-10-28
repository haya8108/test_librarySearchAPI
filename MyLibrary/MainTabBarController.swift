//
//  MainTabBarController.swift
//  MyLibrary
//
//  Created by haya on 2018/10/28.
//  Copyright © 2018年 haya. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
    
        let testCtrl = UINavigationController(rootViewController: UIViewController())
        testCtrl.tabBarItem.image = #imageLiteral(resourceName: "ribbon")
        testCtrl.tabBarItem.selectedImage = #imageLiteral(resourceName: "ribbon")
       
        let tempTestCtrl = templateNavController(unselectedImage: #imageLiteral(resourceName: "ribbon"), selectedImage: #imageLiteral(resourceName: "ribbon"), rootViewController: UIViewController())
        
        viewControllers = [
        testCtrl,
        tempTestCtrl]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
        
    }
    
}
