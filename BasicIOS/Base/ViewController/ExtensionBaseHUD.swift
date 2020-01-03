//
//  ExtensionBaseHUD.swift
//  templates
//
//  Created by kimo on 2017/7/18.
//  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MBProgressHUD

extension BaseViewController {
    
    
    //MBProgressHUD Prompt,Can setting Text and Font Size
    func RCPAlertHUD(strNotice:String, flSize:CGFloat?)
    {
        let hud=MBProgressHUD.showAdded(to: (self.navigationController?.view)!, animated: true);
        hud.mode=MBProgressHUDMode.text;
        hud.label.text=strNotice;
        hud.label.textColor=UIColor.white;
        
        if (flSize == nil)
        {
            hud.label.font=UIFont.boldSystemFont(ofSize: 17.0);
        }
        else
        {
            hud.label.font=UIFont.boldSystemFont(ofSize: flSize!);
        }
        
        hud.backgroundColor=UIColor.init(red: 30/255.0, green: 30/255.0, blue: 30/255.0, alpha: 0.3)
        hud.show(animated: true)
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    
    // The prompt of option button,Can setting Text
    func RCPAlertOptionNotic(strNotice:String)
    {
        let alertController = UIAlertController(title:strNotice, message: nil, preferredStyle: UIAlertController.Style.alert)
        let alertActionOption=UIAlertAction(title: "确定", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(alertActionOption)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
