//
//  OneViewController.swift
//  templates
//
//  Created by kimo on 2017/7/27.
//  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class OneViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ZiDivInitNavigation(ZiDivTitle: "首页")
        
//        let  btnTemp:UIButton=UIButton.init(frame: CGRect(x: 0, y: 687, width: ZDScreenWidth, height: 60))
//
//        btnTemp.setTitle("xxxxx", for: UIControlState.normal)
//        btnTemp.setTitleColor(UIColor.red, for: UIControlState.normal)
//        btnTemp.backgroundColor=UIColor.green
//        self.view.addSubview(btnTemp)
        
        self.view.backgroundColor=UIColor.blue;
        // Do any additional setup after loading the view.
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
