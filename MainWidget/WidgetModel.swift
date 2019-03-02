// Copyright © 2019年 Zilly, Inc. All rights reserved.

import UIKit

class WidgetModel: NSObject, Codable {
    @objc var imageName: String
    @objc var name: String
    @objc var date: String
    @objc var content: String

    init(name: String, date: String, content: String, imageName: String) {
        self.name = name
        self.date = date
        self.content = content
        self.imageName = imageName
    }
}
