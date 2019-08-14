# RITLAlertViewController

思路来源于[(Objective-C)ASPopupController](https://github.com/Hcy91425/ASPopupController)


- AlertController
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
- 预览样式

<img src="https://github.com/RITL/RITLAlertViewController/blob/master/RITLAlertViewController/Preview/AlertController.jpg" width=200></img>

- SheetController
```
@IBAction func presentAlertController(_ sender: Any) {
    
    let alertController = RITLAlertController(title: "测试", message: "我是测试消息消息呀\n测试呀测试呀", titleConfig: { (titleLabel) in
        
    }) { (messageLabel) in
        
    }
    
    alertController.addAction(action: RITLAlertAction(title: "确定", style: .normal, tapHander: {
        
    }))
    
    alertController.addAction(action: RITLAlertAction(title: "取消", style: .cancle, tapHander: {

    }))
    
    alertController.addAction(action: RITLAlertAction(title: "a啦啦啦", style: .destructive, tapHander: {
        
    }))
    
    present(alertController, animated: true, completion: nil)
}
```
- 预览样式

<img src="https://github.com/RITL/RITLAlertViewController/blob/master/RITLAlertViewController/Preview/SheetController.jpg" width=200></img>

