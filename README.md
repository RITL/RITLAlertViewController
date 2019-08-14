# RITLAlertViewController

思路来源于[(Objective-C)ASPopupController](https://github.com/Hcy91425/ASPopupController)


## Alert Style
```
@IBAction func presentAlertController(_ sender: Any) {
    
    let alertController = RITLAlertController(title: "测试", message: "我是测试消息消息呀\n测试呀测试呀", titleConfig: { (titleLabel) in
        
    }) { (messageLabel) in
        
    }
    
    alertController.addAction(action: RITLAlertAction(title: "确定", style: .normal, tapHander: {
        
    }))

    
    alertController.addAction(action: RITLAlertAction(title: "a啦啦啦", style: .destructive, tapHander: {
        
    }))
    
    present(alertController, animated: true, completion: nil)
}

```
预览样式

<img src="https://github.com/RITL/RITLAlertViewController/blob/master/RITLAlertViewController/Preview/RITLAlertController.jpg" width=300></img>

## Sheet Style
```
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
```
预览的样式

<img src="https://github.com/RITL/RITLAlertViewController/blob/master/RITLAlertViewController/Preview/RITLSheetController.jpg" width=200></img>

