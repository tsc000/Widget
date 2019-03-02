//
//  BaseNavigationViewController.swift
//  MainApp
//
//  Created by zilly.MAC009 on 2019/3/1.
//  Copyright © 2019 zilly.MAC009. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationBar = UINavigationBar.appearance()
        let rgb:CGFloat = 0.1
        navigationBar.barTintColor = UIColor(red: rgb, green: rgb, blue: rgb, alpha: 0.9)
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
