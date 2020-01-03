//
//  ComTopBannerDAL.swift
//  templates
//
//  Created by kimo on 2017/7/18.
//  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import Foundation

class ComTopBannerDAL:BaseDAL {
    
    static let singleton = ComTopBannerDAL();
    
    func requestTopBanner(parameters:NSDictionary,complete:@escaping(ModelApiData?)->())
    {
        RCPGetRequest(action: "Account/Banner", parameters: parameters, complete: complete)
    }
}
	
