//
//  ComTabBar.swift
//  templates
//
//  Created by kimo on 2017/7/27.
//  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class ComTabBar: UITabBarController {
    
    var btnTabBar:UIButton!
    var arrTabBarData:NSArray!
    var flBarWidth:CGFloat=RCPScreenWidth/4
    var flBarLblWidth:CGFloat=RCPScreenWidth/4
    var imgVBefore:UIImageView!
    var imgVCurrent:UIImageView!
    var lblTransfer:UILabel!
    var vTabBar:UIView!
    
    
    let flBarLblHeight:CGFloat=RCPTabBarHeight/2-10
    let flBarImgWidth:CGFloat=RCPTabBarHeight*(0.48)
    let flBarImgHeight:CGFloat=RCPTabBarHeight*(0.48)
    let colorOfBarTxt=UIColor.init(red: 138/255.0, green: 138/255.0, blue: 138/255.0, alpha: 1)
    let colorOfBarTouchTxt=UIColor.init(red: 18/255.0, green: 150/255.0, blue: 219/255.0, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tabBar.isHidden=true
        initTabOfVC()
        initTabBar()
    }
    
    func initTabOfVC()
    {
        
        let arrVC = [OneViewController(),TwoViewController(),ThreeViewController(),FourViewController()]
        var arrControllers:[UINavigationController] = []
        
        flBarWidth=RCPScreenWidth/CGFloat(arrVC.count)
        flBarLblWidth=flBarWidth
        
        for item in arrVC
        {
            arrControllers.append(UINavigationController(rootViewController: item));
        }
        
        self.viewControllers=arrControllers;
    }
    
    func initTabBar()
    {
        vTabBar=UIView.init(frame: CGRect(x: 0, y: CGFloat(RCPScreenHeight-RCPTabBarHeight), width: RCPScreenWidth, height: RCPTabBarHeight))
        vTabBar.backgroundColor=UIColor.init(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
        vTabBar.layer.shadowOffset=CGSize(width: 1, height: 1)
        vTabBar.layer.shadowRadius=1
        vTabBar.layer.shadowOpacity=1.0
        vTabBar.layer.shadowColor=UIColor.black.cgColor
        self.view.addSubview(vTabBar)
        
        let baseVC=BaseViewController()
        arrTabBarData = baseVC.RCPPlist(strSet: "RCPTab")
        let intBtnCount=arrTabBarData.count
        
        btnTabBar=UIButton.init(frame: CGRect(x: 0, y: 0, width: RCPScreenWidth/CGFloat(intBtnCount), height: RCPTabBarHeight))
        vTabBar.addSubview(btnTabBar)
        
        for i in 0...intBtnCount-1
        {
            let btnInTabBar=UIButton.init(frame: CGRect(x: RCPScreenWidth*CGFloat(i)/CGFloat(intBtnCount), y: 0, width: RCPScreenWidth/CGFloat(intBtnCount), height: RCPTabBarHeight))
            btnInTabBar.tag=100+i
            btnInTabBar.backgroundColor=UIColor.clear
            btnInTabBar.addTarget(self, action: #selector(actionTabTouch), for: UIControl.Event.touchUpInside)
            initTabContext(i: i, intBtnCount: intBtnCount, btnInTabBar: btnInTabBar)
            vTabBar.addSubview(btnInTabBar)
        }
    }
    
    
    func initTabContext(i:Int,intBtnCount:Int,btnInTabBar:UIButton)
    {
        let modelTabBar=ModelTabBar()
        let tabBarData:NSDictionary = arrTabBarData[i] as! NSDictionary
        modelTabBar.mj_setKeyValues(tabBarData)
        
        let imgVBar=UIImageView.init(frame: CGRect(x: (flBarWidth-flBarImgWidth)/2, y: 5, width: flBarImgWidth, height: flBarImgHeight))
        imgVBar.image=UIImage.init(named:modelTabBar.image )
        imgVBar.tag=300+i
        btnInTabBar.addSubview(imgVBar)
        
        let lblBar=UILabel.init(frame: CGRect(x: 0, y: 6+flBarImgHeight, width: flBarLblWidth, height: flBarLblHeight))
        lblBar.text=modelTabBar.name
        lblBar.font=UIFont.systemFont(ofSize: 10)
        lblBar.textColor=UIColor.gray
        lblBar.isUserInteractionEnabled=false
        lblBar.tag=200+i
        lblBar.textAlignment=NSTextAlignment.center
        btnInTabBar.addSubview(lblBar)
        
        if i == 0
        {
            imgVBar.image=UIImage.init(named:modelTabBar.image_touch)
            imgVBefore=imgVBar
            lblTransfer=UILabel.init()
            lblBar.textColor=colorOfBarTouchTxt
        }
        
    }
    
   @objc  func actionTabTouch(btnInTabBar:UIButton)
    {
        self.selectedIndex=btnInTabBar.tag-100
        if(lblTransfer.tag != btnInTabBar.tag+100)
        {
            lblTransfer.textColor=colorOfBarTxt
            lblTransfer=self.vTabBar.viewWithTag(200) as? UILabel
            lblTransfer.textColor=colorOfBarTxt
            lblTransfer=self.vTabBar.viewWithTag(btnInTabBar.tag+100) as? UILabel
            lblTransfer.textColor=colorOfBarTouchTxt
        }
        
        
        if imgVBefore.tag != btnInTabBar.tag+200
        {
            var modelTabBar=ModelTabBar()
            modelTabBar.mj_setKeyValues(arrTabBarData[Int(imgVBefore.tag%100)])
            imgVBefore.image=UIImage.init(named:modelTabBar.image)
            
            modelTabBar=ModelTabBar()
            modelTabBar.mj_setKeyValues(arrTabBarData[Int(btnInTabBar.tag%100)])
            imgVCurrent=self.vTabBar.viewWithTag(btnInTabBar.tag+200) as? UIImageView
            imgVCurrent.image=UIImage.init(named: modelTabBar.image_touch)
            
            imgVBefore=self.vTabBar.viewWithTag(btnInTabBar.tag+200) as? UIImageView
            
            UIView.animate(withDuration: 0, animations: {
                self.btnTabBar.center=CGPoint(x:btnInTabBar.center.x,y:btnInTabBar.center.y+7.5)
            }, completion: nil)
        }
    }
    
    
    func actionHiddenBar(isHidden:Bool)
    {
        self.tabBar.isHidden=isHidden
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
