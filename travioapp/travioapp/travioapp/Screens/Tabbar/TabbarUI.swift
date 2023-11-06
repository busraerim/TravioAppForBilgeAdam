//
//  TabbarUI.swift
//  travioapp
//
//  Created by Büşra Erim on 1.11.2023.
//

import UIKit
import SnapKit
import TinyConstraints

class TabbarUI: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = setupControllers()
        self.selectedIndex = 0
        self.tabBar.tintColor = UIColor(hex: "#38ADA9")
        self.tabBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        self.tabBar.isTranslucent = false
    }
    
    private func setupControllers()->[UIViewController]{
        let homeVC = HomeUIVC()
        let homeNC = UINavigationController(rootViewController: homeVC)
        let image = UIImage(named: "home2")
        let selectedImage = UIImage(named: "home2")
        homeNC.tabBarItem = UITabBarItem(title: "Home", image: image, selectedImage: selectedImage)

        let menuVC = SettingsView()
        let menuNC = UINavigationController(rootViewController: menuVC)
        let imageSetting = UIImage(named: "setting1")
        let selectedImageSetting = UIImage(named: "setting2")
        menuNC.tabBarItem = UITabBarItem(title: "Menu", image: imageSetting, selectedImage: selectedImageSetting)
        
        let visitVC = MyVisitsView()
        let visitNC = UINavigationController(rootViewController: visitVC)
        let imageVisit = UIImage(named: "visit1")
        let selectedImageVisit = UIImage(named: "visit2")
        visitNC.tabBarItem = UITabBarItem(title: "Visits", image: imageVisit, selectedImage: selectedImageVisit)
        
        let mapVC = MapVC()
        let mapNC = UINavigationController(rootViewController: mapVC)
        let imageMap = UIImage(named: "map1")
        let selectedImageMap = UIImage(named: "map2")
        mapNC.tabBarItem = UITabBarItem(title: "Map", image: imageMap, selectedImage: selectedImageMap)
        
        return [homeNC,visitNC,mapNC,menuNC]
        
    }
    
}
