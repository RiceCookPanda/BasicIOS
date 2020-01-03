//
//  ThreeViewController.swift
//  templates
//
//  Created by kimo on 2017/7/27.
//  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class ThreeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RCPInitNavigation(RCPTitle: "专题")
        // Do any additional setup after loading the view.
         self.view.backgroundColor=UIColor.red;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
