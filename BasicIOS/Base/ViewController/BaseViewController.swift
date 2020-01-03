//
//  BaseViewController.swift
//  templates
//
//  Created by kimo on 2017/7/14.
//  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import Reachability


let RCPColorNav:UIColor=UIColor.init(red: 18/255.0, green: 150/255.0, blue: 219/255.0, alpha: 1)
let RCPColorLine:UIColor=UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)

let RCPScreenWidth = UIScreen.main.bounds.width;
let RCPScreenHeight = UIScreen.main.bounds.height;

let RCPTabBarHeight=CGFloat(49.0)
//let RCPViewHeight = UIScreen.mai∫n.applicationFrame.height;


class BaseViewController: UIViewController {
    
    var reachability:Reachability!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        RCPNetWorkAndNotice()
    }
    
    //initialize Navigation , set title
    func RCPInitNavigation(RCPTitle:String)
    {
        let dicAttributes:NSDictionary=[NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 19)]

        
        self.title=RCPTitle
        self.view.backgroundColor=UIColor.white
        
        self.navigationController?.isNavigationBarHidden=false
        self.navigationController?.isToolbarHidden=true
        self.navigationController?.navigationBar.barTintColor=RCPColorNav
        self.navigationController?.navigationBar.isTranslucent=false
        self.navigationController?.navigationBar.titleTextAttributes=dicAttributes as? [NSAttributedString.Key : Any]
    }
    
    
    // initialize Navigation , set title and leftBarButton
    func RCPInitNavigation(RCPTitle:String ,isRoot:Bool)
    {
        let dicAttributes:NSDictionary=[NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 19)]
        
        let btnLeft:UIButton=UIButton();
        btnLeft.frame=CGRect(x: 0, y: 0, width: 15, height: 25)
        btnLeft.setBackgroundImage(UIImage.init(named: "icon_back.png"), for: UIControl.State.normal)
        if isRoot
        {
            btnLeft.addTarget(self, action:#selector(RCPBtnRoot), for: UIControl.Event.touchUpInside)
        }
        else
        {
            btnLeft.addTarget(self, action: #selector(RCPBtnBack), for: UIControl.Event.touchUpInside)
        }
        
        self.title=RCPTitle
        self.view.backgroundColor=UIColor.white
        
        self.navigationController?.isToolbarHidden=true
        self.navigationController?.navigationBar.barTintColor=RCPColorNav
        self.navigationController?.navigationBar.isTranslucent=false
        self.navigationController?.navigationBar.titleTextAttributes=dicAttributes as? [NSAttributedString.Key : Any]
        self.navigationItem.leftBarButtonItem=UIBarButtonItem.init(customView: btnLeft)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
