//
//  BaseFunc.swift
//  templates
//
//  Created by kimo on 2017/7/27.
//  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class BaseFunc: NSObject {
    
    // get data for Plist's file
    func RCPPlist(strSet:String)->NSDictionary
    {
        let bundle:Bundle = Bundle()
        let plistURL = bundle.url(forResource: "RCPSettings", withExtension: "plist")
        let dicSetting =  NSDictionary(contentsOf: plistURL!)
        return dicSetting?.value(forKey: strSet ) as! NSDictionary;
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
