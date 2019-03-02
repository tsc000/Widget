//
//  BaseTableViewController.swift
//  MainApp
//
//  Created by zilly.MAC009 on 2019/3/1.
//  Copyright © 2019 zilly.MAC009. All rights reserved.
//

import UIKit

class BaseTableViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
    }

    private func setUpViewControllers() {
        let viewControllers = [HomeViewController(), AddressBookViewController(), DiscoveryViewController(), MeViewController()]

        let images = [
            UIImage(named: "tabbar_mainframe") ?? UIImage(),
            UIImage(named: "tabbar_contacts") ?? UIImage(),
            UIImage(named: "tabbar_discover") ?? UIImage(),
            UIImage(named: "tabbar_me") ?? UIImage()]

        let selectedImages =  [
            UIImage(named: "tabbar_mainframeHL") ?? UIImage(),
            UIImage(named: "tabbar_contactsHL") ?? UIImage(),
            UIImage(named: "tabbar_discoverHL") ?? UIImage(),
            UIImage(named: "tabbar_meHL") ?? UIImage()]
        let titles = ["微信", "通讯录", "发现", "我"]

        for i in 0..<viewControllers.count {
            addTabBarChildViewController(image:images[i], selectedImage:selectedImages[i], viewController: viewControllers[i], title: titles[i])
        }
    }

    func alert(title: String, cancelString: String, confirmString: String) {
        let alertVC = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelString, style: .cancel) { (action) in

        }

        let confirmAction = UIAlertAction(title: confirmString, style: .default) { (action) in

        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(confirmAction)
        present(alertVC, animated: true, completion: nil)
    }

    //title默认是空
    private func addTabBarChildViewController(image:UIImage?, selectedImage: UIImage?, viewController:UIViewController, title: String = "") {
        let navigation = BaseNavigationViewController(rootViewController: viewController)
        //        navigation.preferredStatusBarStyle = .lightContent

        let tabBarItem = viewController.tabBarItem

        tabBarItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black as Any], for: .normal)
        tabBarItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0/0xff, green: 190/0xff, blue: 1/0xff, alpha: 1.0) as Any], for: .selected)

        if !title.isEmpty {
            viewController.title = title
            viewController.navigationItem.title = title
        }

        viewController.tabBarItem.image = image?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)

        addChild(navigation)
    }


}
