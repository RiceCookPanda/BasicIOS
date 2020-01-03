//
//  ModelOfMenuI.swift
//  templates
//
//  Created by kimo on 2020/1/2.
//  Copyright © 2020 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class ModelOfMenuI
{     //一级菜单属性
    ///标题名称（名称不可重复)
    var  name:String?
    ///值 id   (值不可重复)
    var  value:String?
    ///图片
    var  image:String?
    //二级菜单集合
    var  TowMenu = [ModelMenuII]()    
}

//二级菜单属性
class ModelMenuII
{
    ///标题名称（名称不可重复)
    var  name:String?
    ///值 id   (值不可重复)
    var  value:String?
    ///父级编号
    var parentid:String?
    ///图片
    var  image:String?
}
