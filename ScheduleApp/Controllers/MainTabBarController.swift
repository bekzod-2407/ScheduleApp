//
//  ViewController.swift
//  ScheduleApp
//
//  Created by Bekzod Qahhorov on 01/08/22.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        
        let scheduleViewController =  createNavController(with: SheduleViewController(), name: "Schedule", itemImage: "calendar.badge.clock")
        let tasksViewController =  createNavController(with: TasksViewController(), name: "Tasks", itemImage: "text.badge.checkmark")
        let contactsViewController =  createNavController(with: ContactsViewController(), name: "Contacts", itemImage: "rectangle.stack.person.crop")
        
        viewControllers = [scheduleViewController,tasksViewController,contactsViewController]
        tabBar.backgroundColor = .systemGray6
      
    }

    func createNavController(with vc : UIViewController, name itemName: String , itemImage: String) -> UINavigationController {
        
        let item  = UITabBarItem(title: itemName, image: .init(systemName: itemImage), tag: 0)
        let navController = UINavigationController(rootViewController: vc)
       
        navController.tabBarItem = item
        
        navController.toolbar.backgroundColor = .red
        return navController
    }
}

