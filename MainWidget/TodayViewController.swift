//
//  TodayViewController.swift
//  MainWidget
//
//  Created by zilly.MAC009 on 2019/2/27.
//  Copyright © 2019年 zilly.MAC009. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate, UITableViewDataSource {
    private let kScreenWidth = UIScreen.main.bounds.size.width
    private var cellCount = 1
    private var rowHeight:CGFloat = 110

    let group = DispatchGroup()
    let queue = DispatchQueue(label: "request_queue")
    private var models: [WidgetModel] = []

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 8, height: 0), style: .plain)
        tableView.register(WidgetTableViewCell.self, forCellReuseIdentifier: .ZLWidgetTableViewCellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = CGFloat(rowHeight)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setWidgetFileData()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        view.addSubview(tableView)
        models.remove(at: 0)
        let model = fetchWidgetData()
        models.insert(model, at: 0)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            ])
    }

    //获取主项目设置widget数据(通过FileManager)
    func setWidgetFileData() {
        let manager = FileManager.default
        var url = manager.containerURL(forSecurityApplicationGroupIdentifier: "group.tsc")
        //路径上多了个file:// 要去掉
        var urlString = url!.absoluteString.replacingOccurrences(of: "file://", with: "")
        url?.appendPathComponent("Library/MainWidget/group.json")

        urlString.append("Library/MainWidget/group.json")
        //获取json数据
        if manager.fileExists(atPath: urlString) {
            do {
                let json = try! String(contentsOf: url!)
                let modelArray = try? JSONDecoder().decode([WidgetModel].self, from: json.data(using: .utf8)!)
                models = modelArray ?? []
            }
        } else {
            print("不存在")
        }
    }

    //获取主项目设置widget数据(通过Userdefaults)
    func fetchWidgetData() -> WidgetModel {
        let userDefault = UserDefaults(suiteName: "group.tsc")
        let model = WidgetModel(name: userDefault?.string(forKey: "FirstDataName") ?? "未获从主App取到名字", date: "Yesterday", content: userDefault?.string(forKey: "FirstDataContent") ?? "未从主App获取到内容", imageName: "Report_Success_icon_120x120_")
        return model
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            cellCount = 1
        } else {
            cellCount = 5
            //iOS 10, SE
            if let height = extensionContext?.widgetMaximumSize(for: .expanded).height {
                cellCount = Int(height / rowHeight)
                if cellCount > 5 { cellCount = 5 } //ios11 12 for xr xmax
            }
        }
        preferredContentSize = CGSize(width: 0, height: CGFloat(cellCount) * rowHeight)
        tableView.reloadData()
    }

    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.newData)
    }

    // MARK: UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .ZLWidgetTableViewCellID) as! WidgetTableViewCell
        let model = models[indexPath.row]
        cell.setName(model.name)
        cell.setDate(model.date)
        cell.setContent(model.content)
        cell.setImage(model.imageName)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        extensionContext?.open(URL(string: "MainWidgetScheme://action=rich")!, completionHandler: { (_) in
        })
    }
}

extension String {
    static let ZLWidgetTableViewCellID = "ZLWidgetTableViewCellID"
}
