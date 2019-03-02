//
//  DiscoveryViewController.swift
//  MainApp
//
//  Created by zilly.MAC009 on 2019/3/1.
//  Copyright © 2019 zilly.MAC009. All rights reserved.
//

import UIKit

class DiscoveryViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    private let kScreenWidth = UIScreen.main.bounds.size.width

    lazy var groupModels: [[TSCModel]] = {
        var groupModels = [[TSCModel]]()
        var groupOne = [TSCModel]()
        var groupTwo = [TSCModel]()
        var groupThree = [TSCModel]()
        var groupFour = [TSCModel]()
        var groupFive = [TSCModel]()
        //groupOne
        let t1 = TSCModel(image: "disIconShowAlbum", title: "朋友圈")
        groupOne.append(t1)
        //groupTwo
        let t2 = TSCModel(image: "disIconQRCode", title: "扫一扫")
        groupTwo.append(t2)
        let t3 = TSCModel(image: "disIconShake", title: "摇一摇")
        groupTwo.append(t3)
        //groupThree
        let t4 = TSCModel(image: "ws_browse_share_24x24_", title: "看一看")
        groupThree.append(t4)
        let t5 = TSCModel(image: "WCPay_TransToBank_Fail_40x40_", title: "搜一搜")
        groupThree.append(t5)
        //groupFour
        let t6 = TSCModel(image: "disIconLocationService", title: "附近的人")
        groupFour.append(t6)
        //groupFive
        let t7 = TSCModel(image: "WAMsg_WeAppLogo_14x14_", title: "小程序")
        groupFive.append(t7)
        groupModels.append(groupOne)
        groupModels.append(groupTwo)
        groupModels.append(groupThree)
        groupModels.append(groupFour)
        groupModels.append(groupFive)
        return groupModels
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 8, height: 0), style: .grouped)
        tableView.register(UINib(nibName: "TSCCell", bundle: nil), forCellReuseIdentifier: String.ZLWidgetTableViewCellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.0001))
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            ])
    }

    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupModels.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupModels[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .ZLWidgetTableViewCellID) as! TSCCell
        let model = groupModels[indexPath.section][indexPath.row]
        cell.imgView.image = UIImage(named: model.image ?? "")
        cell.descLabe.text = model.title
        if groupModels[indexPath.section].count == 1 {
            cell.seperatorView.isHidden = true
        } else {
            if indexPath.row == groupModels[indexPath.section].count - 1 {
                cell.seperatorView.isHidden = true
            } else {
                cell.seperatorView.isHidden = false
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0001
        }
        return 10
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView(frame: CGRect.null)
        }
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 10))
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.null)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        extensionContext?.open(URL(string: "tellusdev://action=rich")!, completionHandler: { (_) in
        })
    }
}

extension String {
    static let ZLWidgetTableViewCellID = "ZLWidgetTableViewCellID"
    static let ZLWidgetHeaderTableViewCellID = "ZLWidgetHeaderTableViewCellID"
}
