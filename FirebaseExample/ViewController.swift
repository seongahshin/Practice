//
//  ViewController.swift
//  FirebaseExample
//
//  Created by 신승아 on 2022/10/05.
//

import UIKit
import FirebaseAnalytics

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Analytics.logEvent("share_image", parameters: [
          "name": "고래밥",
          "full_text": "안녕하세요",
        ])

        Analytics.setDefaultEventParameters([
          "level_name": "Caverns01",
          "level_difficulty": 4
        ])
    }

    @IBAction func profileButtonClicked(_ sender: UIButton) {
        present(ProfileViewController(), animated: true)
    }
    
    @IBAction func settingButtonClicked(_ sender: UIButton) {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    @IBAction func crashClicked(_ sender: UIButton) {
        
    }
    
}

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .brown
    }
}

class SettingViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .lightGray
    }
}


extension UIViewController {
    var topViewController: UIViewController? {
        return self.topViewController(currentViewController: self)
    }
    
    // 최상위 뷰컨트롤러를 판단해주는 메서드
    func topViewController(currentViewController: UIViewController) -> UIViewController {
        if let tabBarController = currentViewController as? UITabBarController, let selectedViewController = tabBarController.selectedViewController {
            return self.topViewController(currentViewController: selectedViewController)
        } else if let navigationController = currentViewController as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
            return self.topViewController(currentViewController: visibleViewController)
        } else if let presentedViewController = currentViewController.presentedViewController {
            return self.topViewController(currentViewController: presentedViewController)
        } else {
            return currentViewController
        }
    }
}


