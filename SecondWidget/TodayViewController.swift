//
//  TodayViewController.swift
//  SecondWidget
//
//  Created by zilly.MAC009 on 2019/3/2.
//  Copyright © 2019 zilly.MAC009. All rights reserved.
//

import UIKit
import NotificationCenter
import SnapKit

class TodayViewController: UIViewController, NCWidgetProviding {

    private let kScreenWidth = UIScreen.main.bounds.size.width
    lazy var buttonContainer: UIStackView = {
        let btn = UIStackView()
        btn.distribution = .fillEqually
        view.addSubview(btn)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        let titleArray: [String] = ["扫一扫", "付钱", "收钱", "转账", "乘车码"]
        let imageArray: [String] = ["saoyisao_34x34_", "fukuan_34x34_", "shouqian_35x34_", "zhuanzhang_34x34_", "chengchema_34x34_"]
        for (i, _) in titleArray.enumerated() {
            let button = setUpButtons(image: imageArray[i], title: titleArray[i])
            button.tag = 100 + i
            buttonContainer.addArrangedSubview(button)
            button.addTarget(self, action: #selector(buttonDidClick(_:)), for: .touchUpInside);
        }
    }

    @objc func buttonDidClick(_ sender: UIButton) {
        var action = ""
        switch sender.tag {
        case 100:
            action = "scan"
        case 101:
            action = "pay"
        case 102:
            action = "rec"
        case 103:
            action = "zhuanzhang"
        case 104:
            action = "code"
        default:
            break
        }
        extensionContext?.open(URL(string: "MainWidgetScheme://action=\(action)")!, completionHandler: { (_) in
        })
    }

    func setUpButtons(image: String, title: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.setImage(UIImage(named: image), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        let space: CGFloat = 50
        let titleSize = btn.titleLabel!.frame.size
        let imageSize = btn.imageView!.frame.size
        let margin:CGFloat = title.count == 3 ? 33 : 45
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width-margin, bottom: -imageSize.height-space/2.0, right: 0)
        btn.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height-space/2.0 - 10 , left: -titleSize.width + 10, bottom: -0, right: -titleSize.width)
        return btn
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
