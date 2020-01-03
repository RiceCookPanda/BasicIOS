//
//  ViewController.swift
//  templates
//
//  Created by kimo on 2017/7/13.
//  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        RCPInitNavigation(RCPTitle: "首页")
        
        let comTopBanner =  ComTopBanner()
        self.addChild(comTopBanner)
        self.view.addSubview(comTopBanner.view)
        
        var btnTest:UIButton!
        btnTest =  UIButton.init(frame: CGRect(x: 20, y: 300, width: 100, height: 60));
        btnTest.addTarget(self, action: #selector(ActionBtnTest), for: UIControl.Event.touchUpInside)
        btnTest.setTitle("wowu", for: UIControl.State.normal)
        btnTest.setTitleColor(UIColor.red, for: UIControl.State.normal)
        self.view.addSubview(btnTest)
        
    }
    
    @objc func ActionBtnTest()
    {
        let comWebView=ComWebView()
        comWebView.strWebUrl="http://www.baidu.com"
        self.navigationController?.pushViewController(comWebView, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

