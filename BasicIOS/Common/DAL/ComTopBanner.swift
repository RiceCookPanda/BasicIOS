    //
    //  ComTopBanner.swift
    //  templates
    //
    //  Created by kimo on 2017/7/18.
    //  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
    //
    
    import UIKit
    import TAPageControl
    import SDWebImage
    
    class ComTopBanner: BaseViewController,UIScrollViewDelegate
    {
        var imgCount:Int!
        var imgVTopBanner:UIImageView!
        var modelApiData = ModelApiData()
        var svImage:UIScrollView!
        var timer:Timer!
        var tapPage:TAPageControl!
        
        let svHeight=RCPScreenHeight/4;
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            initTheBanner()
        }
        
        
        func initTheBanner()
        {
            self.view.backgroundColor=UIColor.red
            self.view.frame=CGRect(x: 0, y: 0, width: RCPScreenWidth, height: svHeight+64)
            weak var weakSelf = self
            
            ComTopBannerDAL.singleton.requestTopBanner(parameters: ["position_id":1 as AnyObject])
            {
                
                (model) in self.modelApiData=model!
                
                if !self.modelApiData.success
                {
                    let strMessage:String=self.modelApiData.message
                    weakSelf?.RCPAlertHUD(strNotice: strMessage, flSize: nil)
                    return
                }
                
                self.imgCount = self.modelApiData.arr_data.count
                
                self.svImage=UIScrollView.init()
                self.svImage.frame=CGRect(x: 0, y: 0, width:RCPScreenWidth, height:self.svHeight)
                self.svImage.isDirectionalLockEnabled=true
                self.svImage.isPagingEnabled=true
                self.svImage.showsVerticalScrollIndicator=false
                self.svImage.showsHorizontalScrollIndicator=false
                self.svImage.delegate=self
                self.svImage.backgroundColor=UIColor.yellow
                self.svImage.contentMode=UIView.ContentMode.scaleToFill
                self.svImage.bounces=true;
                self.svImage.contentSize=CGSize(width: RCPScreenWidth*CGFloat(self.imgCount), height:self.svHeight)
                self.view.addSubview(self.svImage)
                
                
                self.tapPage=TAPageControl.init()
                self.tapPage.frame=CGRect(x: RCPScreenWidth*0.75, y: RCPScreenHeight*0.21, width: RCPScreenWidth*0.25, height: RCPScreenHeight*0.04)
                self.tapPage.numberOfPages=self.modelApiData.arr_data.count;
                self.view.addSubview(self.tapPage)
                
                print(self.svImage.contentOffset.x)
                print(self.svImage.contentOffset.y)
                
                self.initTopImages()
                self.initSVTimer()
            }
            
        }
        
        func initTopImages()
        {
            for i  in 0...imgCount-1
            {
                let modelTopBanner=ModelTopBanner()
                modelTopBanner.mj_setKeyValues(modelApiData.arr_data[i])
                
                let recognizer = UITapGestureRecognizer.init(target: self, action: #selector(actionTopImageTouchUp))
                
                imgVTopBanner = UIImageView.init()
                imgVTopBanner.frame=CGRect(x: RCPScreenWidth*CGFloat(i) , y: 0, width: RCPScreenWidth, height:svHeight)
                imgVTopBanner.contentMode=UIView.ContentMode.scaleToFill;
                imgVTopBanner.isUserInteractionEnabled=true
                imgVTopBanner.sd_setImage(with:URL(string: modelTopBanner.imageurl) , placeholderImage: UIImage.init(named: "icon_temp_shop"))
            
                imgVTopBanner.addGestureRecognizer(recognizer)
                svImage.addSubview(imgVTopBanner)
                print(modelTopBanner.imageurl as Any)
            }
        }
        
        
        func initSVTimer()
        {
            timer = Timer.init()
            timer =  Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(actionHandleMaxShowTimer), userInfo: nil, repeats: true)
        }
        
       @objc  func actionHandleMaxShowTimer(timer:Timer)  {
            
            let point:CGPoint=self.svImage.contentOffset
            
            if point.x >= RCPScreenWidth*CGFloat(imgCount-1)
            {
                self.svImage.setContentOffset(CGPoint(x:0,y:0), animated: true)
            }
            else
            {
                self.svImage.setContentOffset(CGPoint(x:point.x+RCPScreenWidth,y:0), animated: true)
            }
        }
        
        
        @objc func actionTopImageTouchUp(recognizer:UITapGestureRecognizer)
        {
            let modelTopBanner=ModelTopBanner()
            modelTopBanner.mj_setKeyValues(modelApiData.arr_data[tapPage.currentPage])
            
            let comWebView=ComWebView()
            comWebView.strWebUrl=modelTopBanner.src
            self.navigationController?.pushViewController(comWebView, animated: true)
        }
        
        
        func scrollViewDidScroll(_ scrollView: UIScrollView)
        {
            var intPageIndex = Int(svImage.contentOffset.x/RCPScreenWidth);
            
            if intPageIndex==imgCount
            {
                intPageIndex = intPageIndex-1
            }
            
            self.tapPage.currentPage=intPageIndex;
        }
        
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            timer.invalidate()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if timer != nil {
                initSVTimer()
            }
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
