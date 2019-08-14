//
//  ViewController.swift
//  RITLAlertViewController
//
//  Created by YueWen on 2019/8/13.
//  Copyright © 2019 YueWen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func presentAlertController(_ sender: Any) {
        
        let alertController = RITLAlertController(title: "测试", message: "我是测试消息消息呀\n测试呀测试呀", titleConfig: { (titleLabel) in
            print("设置标题样式")
        }) { (messageLabel) in
            print("设置message样式")
        }
        
        alertController.addAction(action: RITLAlertAction(title: "确定", style: .normal, tapHander: {}))
        
        alertController.addAction(action: RITLAlertAction(title: "取消", style: .custom(config: { (button) in
            
            button.setTitleColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), for: .normal)
            
        }), tapHander: {}))
        
        alertController.addAction(action: RITLAlertAction(title: "a啦啦啦", style: .destructive, tapHander: {}))
        
        present(alertController, animated: true, completion: nil)
    }

}

