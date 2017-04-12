//
//  AppDelegate.swift
//  JavaScriptCallbackInSwift
//

//  Copyright (c) 2017 BarryBryant. All rights reserved.
//

import UIKit
import TVMLKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appController: TVApplicationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let appControllerContext = TVApplicationControllerContext()
        appControllerContext.launchOptions = [
                "initialJSDependencies": initialJSDependencies()
        ]

        let javascriptURL = Bundle.main.url(forResource: "application",
                withExtension: "js")
        appControllerContext.javaScriptApplicationURL = javascriptURL!

        appController = TVApplicationController(
                context: appControllerContext, window: window,
                delegate: self)

        return true
    }
}

extension AppDelegate {
    fileprivate func initialJSDependencies() -> [String] {
        return [
                "mustache.min",
                "EventHandler"
        ].flatMap {
            let url = Bundle.main.url(forResource: $0, withExtension: "js")
            return url?.absoluteString
        }
    }
}


extension AppDelegate: TVApplicationControllerDelegate {
    func appController(_ appController: TVApplicationController,
                       evaluateAppJavaScriptIn jsContext: JSContext) {
        let dispatchActionClosure = dispatchAction()
        let castedClosure = unsafeBitCast(dispatchActionClosure, to: AnyObject.self)
        jsContext.setObject(castedClosure, forKeyedSubscript: "dispatchAction" as NSString)
    }
}




