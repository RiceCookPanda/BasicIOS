//
//  BaseHttpManager.swift
//  templates
//
//  Created by kimo on 2017/7/18.
//  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import AFNetworking

class BaseHttpManager: AFHTTPSessionManager {
    
    
    enum HTTPRequestType
    {
        case GET
        case POST
    }
    
    static let singleton : BaseHttpManager =
    {
        let baseHttpManager=BaseHttpManager()
        baseHttpManager.requestSerializer=AFJSONRequestSerializer()
        baseHttpManager.responseSerializer=AFJSONResponseSerializer()
        baseHttpManager.responseSerializer.acceptableContentTypes?.insert("text/html")
        return baseHttpManager
    }();
    
    func RCPRequest(requestType:HTTPRequestType,URLString:String,parameters:NSDictionary?,complete:@escaping (NSArray)->())
    {
        let success={(task:URLSessionTask,json :Any )->() in
            complete(json as! NSArray)
        }
        
        let failure={(task:URLSessionTask?,error:Error)->() in
            complete(NSArray.init(array: [{"type:-1"}]) )
        }
        
        if requestType == .POST
        {
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        else
        {
            get(URLString,parameters:parameters,progress:nil,success:success,failure:failure)
        }
    }

    
    func RCPRequest(requestType:HTTPRequestType,URLString:String,parameters:[String:Any]?,complete:@escaping ([String:Any])->())
    {
        let success={(task:URLSessionTask,json :Any )->() in
            complete(json as! [String:Any])
        }
        
        let failure={(task:URLSessionTask?,error:Error)->() in
            complete( ["Status":"-1","Message":error.localizedDescription] )
        }
                
        if requestType == .POST
        {
             post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        else
        {
             get(URLString,parameters:parameters,progress:nil,success:success,failure:failure)
        }
    }
    
}
