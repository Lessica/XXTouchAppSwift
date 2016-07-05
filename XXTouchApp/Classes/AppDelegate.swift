//
//  AppDelegate.swift
//  OneFuncApp
//
//  Created by mcy on 16/5/31.
//  Copyright © 2016年 mcy. All rights reserved.
//

import UIKit

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    if FileManager.sharedManager.respringFileExistsAtPath() {
      JCAlertView.showTwoButtonsWithTitle(Constants.Text.prompt, message: "XXTouch 安装后需要注销以完成服务完全更新，是否立即注销设备？", buttonType: JCAlertViewButtonType.Default, buttonTitle: Constants.Text.ok, click: { 
        MixC.sharedManager.logout()
        }, buttonType: JCAlertViewButtonType.Cancel, buttonTitle: Constants.Text.cancel, click: {
          exit(0)
      })
    } else {
      // 注册 Defaults
      Defaults.configure()
      
      // 加载转菊花配置
      ProgressHUDManager.startConfig()
      
      // 加载程序窗口
      setupAndShowWindow()
    }
    
    return true
  }
  
  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
}

extension AppDelegate {
  private func setupAndShowWindow() {
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    window?.backgroundColor = .whiteColor()
    window?.rootViewController = createRootViewController()
    window?.makeKeyAndVisible()
  }
}

extension AppDelegate {
  private func createRootViewController() -> UIViewController {
    let tabBarController = UITabBarController()
    let scriptNavigationController = UINavigationController(rootViewController: ScriptViewController())
    scriptNavigationController.tabBarItem = UITabBarItem(title: "我的脚本", image: UIImage(named: "scriptTab"), selectedImage: nil)
    
    let catalogNavigationController = UINavigationController(rootViewController: CatalogViewController())
    catalogNavigationController.tabBarItem = UITabBarItem(title: "目录", image: UIImage(named: "scriptTab"), selectedImage: nil)
    
    let moreNavigationController = UINavigationController(rootViewController: MoreViewController())
    moreNavigationController.tabBarItem = UITabBarItem(title: "更多", image: UIImage(named: "moreTab"), selectedImage: nil)
    
    let viewControllers: [UIViewController] = [
      scriptNavigationController,
      moreNavigationController
    ]
    tabBarController.viewControllers = viewControllers
    return tabBarController
  }
}

extension AppDelegate {
  func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.Portrait
  }
}

