//
//  ContainViewCont.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 16/02/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation
class EmbedController {
    
    public private(set) weak var rootViewController: UIViewController?
    
    public private(set) var controllers = [UIViewController]()
    
    init (rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    func append(viewController: UIViewController) {
        if let rootViewController = self.rootViewController {
            controllers.append(viewController)
            rootViewController.addChildViewController(viewController)
            rootViewController.view.addSubview(viewController.view)
        }
    }
    
    deinit {
        if self.rootViewController != nil {
            for controller in controllers {
                controller.view.removeFromSuperview()
                controller.removeFromParentViewController()
            }
            controllers.removeAll()
            self.rootViewController = nil
        }
    }
}
