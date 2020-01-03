//
//  BaseDAL.swift
//  templates
//
//  Created by kimo on 2017/7/18.
//  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import MJExtension

let RCPUrlBase="http://api.easyaim.dzuo.net:9004"

class BaseDAL
{
    
    
    func RCPGetRequest(action:NSString, parameters:NSDictionary?,complete:@escaping(ModelApiData?)->())
    {
        let strUrl="\(RCPUrlBase)\(action)"
        
        let complete={(any:NSArray)->() in complete(self.RCPObjectToModel(arrData: any))}
        
        BaseHttpManager.singleton.RCPRequest(requestType: .GET, URLString : strUrl, parameters:parameters,complete:complete )
    }
    
    func RCPPostRequest(action:NSString, parameters:NSDictionary?,complete:@escaping(ModelApiData?)->())
    {
        let strUrl="\(RCPUrlBase)\(action)"
        
        let complete={(any:NSArray)->() in complete(self.RCPObjectToModel(arrData: any))}
        
        BaseHttpManager.singleton.RCPRequest(requestType: .POST, URLString : strUrl, parameters:parameters,complete:complete )
    }
    
    func RCPObjectToModel(arrData:NSArray) -> ModelApiData {
        
        let model:ModelApiData=ModelApiData()
        
        let dicData:Dictionary<String,Any> = arrData[0] as! Dictionary<String,Any>
        
        model.success=RCPNumberToStatus(strNumber: dicData["type"] as! String)
        //model.message=dicData["Message"] as! String
        
        if model.success &&  dicData.keys.contains("data")
        {
            model.arr_data = dicData["data"] as? [Any]
        }
        
        return model;
    }
    
    
    func RCPObjectToModel(dicData:[String:Any]) -> ModelApiData {
        
        let model:ModelApiData=ModelApiData()
        
        model.success=RCPNumberToStatus(strNumber: dicData["Status"] as! String)
        model.message=dicData["Message"] as? String
        
        if model.success && dicData.keys.contains("ds")
        {
            model.arr_data = dicData["ds"] as? [Any]
        }
        
        return model;
    }
    
    func RCPNumberToStatus(strNumber:String) -> Bool {
        switch strNumber {
        case "1":
            return true
        default:
            return false
        }
    }
    
}
