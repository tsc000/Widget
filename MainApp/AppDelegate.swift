//
//  AppDelegate.swift
//  MainApp
//
//  Created by zilly.MAC009 on 2019/2/27.
//  Copyright © 2019年 zilly.MAC009. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBar = BaseTableViewController()
    private var models: [WidgetModel] = {
        let imageNameArray = ["Report_Success_icon_120x120_", "Report_Success_icon_120x120_", "Report_Success_icon_120x120_", "Report_Success_icon_120x120_", "Report_Success_icon_120x120_"]
        let nameArray = ["Alex & Jessica(FileManager)", "Jessica(FileManager)", "Rocky(FileManager)", "Work Order(FileManager)", "Work Order(FileManager)"]
        let dateArray = ["5:30 pm", "Yesterday", "11/02/2018", "11/02/2018", "11/02/2018"]
        let conentArray = ["Rocky: Where are you Jessic？", "Rocky: Where are you Jessic？I will arrive station about 30n munites later", "Rocky: Where are you Jessic？I will arrive station about 30n munites later", "Rocky: Where are you Jessic？I will arrive station about 30n munites laterRocky: Where are you Jessic？I will arrive station about 30n munites later", "Rocky: Where are you Jessic？I will arrive station about 30n munites laterRocky: Where are you Jessic？I will arrive station about 30n munites later"]
        var array = [WidgetModel]()
        for i in 0..<nameArray.count {
            let model = WidgetModel(name: nameArray[i], date: dateArray[i], content: conentArray[i], imageName: imageNameArray[i])
            array.append(model)
        }
        return array
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        setWidgetData()
        setWidgetFileData()

        let mainDocPath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        print("主App沙盒路径----\(mainDocPath)")
        return true
    }

    //主项目设置widget数据(通过Userdefaults)
    private func setWidgetData() {
        let userDafault = UserDefaults(suiteName: "group.tsc")
        userDafault?.set("主App名字(Userdefaults)", forKey: "FirstDataName")
        userDafault?.set("主App内容(Userdefaults)", forKey: "FirstDataContent")
        userDafault?.synchronize()
    }

    //主项目设置widget数据(通过FileManager)
    func setWidgetFileData() {
        let manager = FileManager.default
        var url = manager.containerURL(forSecurityApplicationGroupIdentifier: "group.tsc")
        //路径上多了个file:// 要去掉
        var urlString = url!.absoluteString.replacingOccurrences(of: "file://", with: "")
        urlString.append("Library/MainWidget")
        //1创建路径和文件
        if !manager.fileExists(atPath: urlString) {
            do {
                if let _:() = try? manager.createDirectory(atPath: urlString, withIntermediateDirectories: true, attributes: nil) {
                    print("路径创建成功")
                    urlString.append("/group.json")
                    do {
                        let result = manager.createFile(atPath: urlString, contents: nil, attributes: nil)
                        result ? print("文件创建成功") : print("文件创建失败")
                    }
                } else {
                    print("路径创建失败")
                }
            }
        }
        //2写入数据
        if let json = serialization() {
            url?.appendPathComponent("Library/MainWidget/group.json")
            print("Group路径----\(url!)")
            if let _:() = try? json.write(to: url!) {
                print("写入成功")
            } else {
                print("写入失败")
            }
        } else {
            print("序列化失败")
        }
    }

    func serialization() -> Data? {
        let encoder = JSONEncoder()
        let resultData = try? encoder.encode(models)
        return resultData
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let urlString = url.absoluteString
        let startIndex = urlString.startIndex
        let string = "MainWidgetScheme://action="

        if urlString.contains(string) {
            let newStartIndex = urlString.index(startIndex, offsetBy: string.count)
            let code = urlString[newStartIndex..<urlString.endIndex]
            switch code {
            case "scan":
                tabBar.alert(title: "扫一扫", cancelString: "取消", confirmString: "确认")
            case "pay":
                tabBar.alert(title: "付款", cancelString: "取消", confirmString: "确认")
            case "rec":
                tabBar.alert(title: "收款", cancelString: "取消", confirmString: "确认")
            case "zhuanzhang":
                tabBar.alert(title: "转账", cancelString: "取消", confirmString: "确认")
            case "code":
                tabBar.alert(title: "乘车码", cancelString: "取消", confirmString: "确认")
            default:
                break
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

