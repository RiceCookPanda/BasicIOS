//
//  ExtensionBaseFunc.swift
//  templates
//
//  Created by kimo on 2017/7/14.
//  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import Reachability

extension BaseViewController {
    
    // return previous page
   @objc func RCPBtnBack()
    {
        self.navigationController?.popViewController(animated: true)
        
        //    RootViewController *rootVC = (RootViewController *)self.tabBarController;
        //    [rootVC showTabBar:YES];
    }
    
    // return RootViewController
   @objc func RCPBtnRoot()
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // Determine the connection status
    func RCPNetWorkAvaliable()->Bool
    {
        // Do any additional setup after loading the view.
       let reachability = try! Reachability()
        var bl=true
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            bl=false;
        }
         return bl;
    }
    
    // Determine the connection status and give notice
    func RCPNetWorkAndNotice()
    {
        
        if RCPNetWorkAvaliable()
        {
            // print("Connection Status:Available")
        }
        else
        {
            let lblNotice:UILabel?=UILabel()
            lblNotice?.frame=CGRect(x: (RCPScreenWidth-300)/2, y: RCPScreenHeight/2, width: 300, height: 30)
            lblNotice?.text="Sorry，网络连接：不可用！"
            lblNotice?.textAlignment = .center
            if #available(iOS 10.0, *) {
                lblNotice?.textColor=UIColor(displayP3Red: 0.8, green: 0, blue: 0, alpha: 1)
            } else {
                lblNotice?.textColor=UIColor(hue: 0.8, saturation: 0.8, brightness: 0.8, alpha: 1)
            }
            
            self.view.addSubview(lblNotice!)
            return
        }
    }

    // get data for Plist's file
    func RCPPlist(strSet:String)->NSArray
    {
        let plistURL = Bundle.main.path(forResource: "Settings", ofType: "plist")
        let dicSetting:NSDictionary =  NSDictionary(contentsOfFile: plistURL!)!
        return dicSetting.value(forKey: strSet ) as! NSArray
    }
    	
    // the UIView object of add underline
    func RCPViewLine(vNeedLine:UIView)
    {
        let vLine:UIView=UIView()
        vLine.frame=CGRect(x: 0, y: vNeedLine.frame.size.height-1, width: RCPScreenWidth, height: 1)
        vLine.backgroundColor=RCPColorLine;
        vNeedLine.addSubview(vLine)
    }

}
	
