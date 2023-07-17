//
//  MainTabbarViewController.swift
//  colonCancer
//
//  Created by KH on 21/04/2023.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let vc1 = UINavigationController(rootViewController: uploadPhotoViewController())
        let vc2 = UINavigationController(rootViewController: HomeViewController())
        let vc3 = UINavigationController(rootViewController: ReminderViewController())
        let vc4 = UINavigationController(rootViewController: InfoTableViewController())
        
        
        
        vc2.tabBarItem.image = UIImage(systemName: "pencil")
        
        vc1.tabBarItem.image = UIImage(systemName: "cross.case")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "cross.case.fill")

        
        vc3.tabBarItem.image = UIImage(systemName: "calendar")

        
        vc4.tabBarItem.image = UIImage(systemName: "info.circle")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "info.circle.fill")

        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)



    }


}


