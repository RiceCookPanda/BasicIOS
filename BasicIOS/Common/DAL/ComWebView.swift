//
//  ComWebViewController.swift
//  templates
//
//  Created by kimo on 2017/7/24.
//  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MBProgressHUD

class ComWebView: BaseViewController ,MBProgressHUDDelegate,UIWebViewDelegate {
    
    var strWebUrl:String!
    var webhud:MBProgressHUD!
    var website:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        RCPInitNavigation(RCPTitle: "活动", isRoot: false)
        
        webhud=MBProgressHUD.init(view: (navigationController?.view)!)
        webhud.delegate=self
        webhud.label.text="loading..."
        webhud.minSize=CGSize(width: 105, height: 80)
        webhud.show(animated: true)
        self.navigationController?.view.addSubview(webhud)
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(actionHide), userInfo: nil, repeats: false)
        
        initContent()

    }
    
    func initContent()
    {
        website=UIWebView.init(frame: CGRect(x: 0, y: 0, width: RCPScreenWidth, height: RCPScreenHeight))
        let thisURL:URL = URL.init(string: strWebUrl)!
        let request = URLRequest.init(url:thisURL, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 1)
     
        website.backgroundColor=UIColor.clear
        website.isOpaque=false
        website.delegate=self
        website.loadRequest(request)
        self.view.addSubview(website)
    }
    
    
   @objc func actionHide(timer:Timer) {
        webhud.hide(animated: true)
        timer.invalidate()
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        if !webhud.isHidden
        {
            webhud.hide(animated: true)
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        webhud.hide(animated: true)
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
