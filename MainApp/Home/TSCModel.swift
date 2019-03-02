//
//  TSCModel.swift
//  MainApp
//
//  Created by zilly.MAC009 on 2019/3/1.
//  Copyright © 2019 zilly.MAC009. All rights reserved.
//

import UIKit

class TSCModel: NSObject {
    var image: String?
    var title: String?
    init(image: String, title: String) {
        self.image = image
        self.title = title
        super.init()
    }
}
