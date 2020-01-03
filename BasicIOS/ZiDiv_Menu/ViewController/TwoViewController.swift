//
//  TwoViewController.swift
//  templates
//
//  Created by kimo on 2017/7/27.
//  Copyright © 2017年 ZiDiao Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DOPDropDownMenu_Enhanced

class OneMenuModel {     //一级菜单属性
    ///标题名称（名称不可重复)
    var  name:String?
    ///值 id   (值不可重复)
    var  value:String?
    ///图片
    var  image:String?
    var  TowMenu = [TowMenuModel]()
    
}
class TowMenuModel {    //二级菜单属性
    ///标题名称（名称不可重复)
    var  name:String?
    ///值 id   (值不可重复)
    var  value:String?
    ///图片
    var  image:String?
}


class  MenuModel {      //对象集合
    var  OneMenu = [OneMenuModel]()
}


class TwoViewController: BaseViewController,DOPDropDownMenuDelegate,DOPDropDownMenuDataSource {
    
    typealias CallbackSelectedValue=(_ name:String,_ value:String)->Void
    
    //声明一个闭包
    private  var myCallbackValue:CallbackSelectedValue?
    //下面这个方法需要传入上个界面的函数指针
    func  Callback_SelectedValue(value:CallbackSelectedValue?){
        //将函数指针赋值给闭
        myCallbackValue = value
    }
    
    var menu = DOPDropDownMenu()    // 菜单
    
    
    private var index=0 //第一次加载数据的索引
    private  var isLoadMenu=false    //是否加载菜单完成？
    
    private var  _MenuValue = [MenuModel]() //菜单数据模型
    
    func AddMenuData(model:MenuModel){
        _MenuValue.append(model)
    }
    
    func SelectedCallBackValue(){
        //选中的必包回调
        self.Callback_SelectedValue { (name, value) in
            print(name,value)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ZiDivInitNavigation(ZiDivTitle: "课程")
        
        
        SelectedCallBackValue() //选中的必包回调
        
        let mol = MenuModel()
        
        for   i:Int in 0  ..< 25 {    //第一个菜单
            
            let Onemol=OneMenuModel()
            Onemol.name="区域\(i)"
            Onemol.value=i.description
            if(i<5){
                Onemol.image="aeroplane"
                for   l:Int in 0  ..< 50 {
                    let Towmol=TowMenuModel()
                    Towmol.name="朝阳\(l)"
                    Towmol.value=i.description
                    if(l==2){
                        Towmol.name="中心"
                        Towmol.image="aeroplane"
                        Towmol.value="123"
                    }
                    if(l==3){
                        Towmol.name="其他"
                        Towmol.image="add-circular"
                        Towmol.value="321"
                    }
                    
                    Onemol.TowMenu.append(Towmol)  //添加二级菜单值
                }
            }
            mol.OneMenu.append(Onemol)
        }
        
        AddMenuData(model: mol)  //新增
        
        let mol1 = MenuModel()
        
        for   i:Int in 0  ..< 3 {
            let Onemol=OneMenuModel()
            Onemol.name="价格\(i)"
            if(i>=1){
                Onemol.name="1000\(i)"
            }
            Onemol.value=i.description
            mol1.OneMenu.append(Onemol)
            
        }
        
        AddMenuData(model: mol1)
        let mol2 = MenuModel()
        for   i:Int in 0  ..< 3 {
            let Onemol=OneMenuModel()
            Onemol.name="户型\(i)"
            Onemol.value=i.description
            mol2.OneMenu.append(Onemol)
            
        }
        AddMenuData(model: mol2)
     
        menureloadData()    //刷新菜单 (每次加载完数据后都需要刷新
        
        
        // Do any additional setup after loading the view.
        menu = DOPDropDownMenu.init(origin: CGPoint(x: 0, y: 0), andHeight: 30);
        menu.fontSize = 13
        menu.detailTextFont = UIFont.systemFont(ofSize: 13)
        menu.cellStyle=UITableViewCell.CellStyle.
        self.view.addSubview(menu)
        menu.isClickHaveItemValid=true
        menu.delegate=self
        menu.dataSource=self

        
        menu.select(DOPIndexPath.init(col: 0, row: 0, item: 0));
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func menureloadData()  {
        menu.reloadData()
    }
    
    
    //返回当前显示的MenuTitle列总数
    func numberOfColumns(in menu: DOPDropDownMenu!) -> Int {
        return  _MenuValue.count
    }
    
    // 返回 menu 第column列有多少行  （一级
    func menu(_ menu: DOPDropDownMenu!, numberOfRowsInColumn column: Int) -> Int {
        if(column>=0){
            let value  = _MenuValue[column]
            return value.OneMenu.count
        }
        
        return 0
    }
    // 返回 menu 第column列 每行title （一级
    func menu(_ menu: DOPDropDownMenu!, titleForRowAt indexPath: DOPIndexPath!) -> String! {
        if(isLoadMenu){
            //每当点击菜单的时候
            let title = _MenuValue[indexPath.column]
            if(title.OneMenu[indexPath.row].name=="" ||
                title.OneMenu[indexPath.row].name==nil){
                return "无数据"
            }
            else{
                return title.OneMenu[indexPath.row].name    //把点击菜单的OneMenu全部显示出来
            }
            
        }
        //第一次加载菜单的时候
        let title = _MenuValue[index]
        index+=1
        if(index==_MenuValue.count){
            isLoadMenu=true
        }
        return title.OneMenu[0].name    //添加数据显示 (显示第一个onemenu)
    }
    
    // 返回 menu 第column列有多少行  （二级
    func menu(_ menu: DOPDropDownMenu!, numberOfItemsInRow row: Int, column: Int) -> Int {
        
        let value  = _MenuValue[column]
        if(value.OneMenu[row].TowMenu.count==0){
            return -1
        }
        return  value.OneMenu[row].TowMenu.count
        
        
    }
    // 返回 menu 第column列 每行title （二级
    func menu(_ menu: DOPDropDownMenu!, titleForItemsInRowAt indexPath: DOPIndexPath!) -> String! {
        
        let title = _MenuValue[indexPath.column]
        if(title.OneMenu[indexPath.row].TowMenu[indexPath.row].name=="" ||
            title.OneMenu[indexPath.row].TowMenu[indexPath.row].name==nil){
            
            return "无数据"
        }
        else{
            let value = title.OneMenu[indexPath.row].TowMenu[indexPath.item].name   //把点击菜单的TowMenu全部显示出来
            return value
        }
        
    }
    //一级菜单图片(文字左边logo
    func menu(_ menu: DOPDropDownMenu!, imageNameForRowAt indexPath: DOPIndexPath!) -> String! {
        let title = _MenuValue[indexPath.column]
        if(title.OneMenu[indexPath.row].image=="" ||
            title.OneMenu[indexPath.row].image==nil){
            return ""
        }
        return title.OneMenu[indexPath.row].image
    }
    //二级菜单图片(文字左边logo
    func menu(_ menu: DOPDropDownMenu!, imageNameForItemsInRowAt indexPath: DOPIndexPath!) -> String! {
        let title = _MenuValue[indexPath.column]
        if(title.OneMenu[indexPath.row].TowMenu[indexPath.row].image=="" ||
            title.OneMenu[indexPath.row].TowMenu[indexPath.row].image==nil){
            
            return "无数据"
        }
        
        return title.OneMenu[indexPath.row].TowMenu[indexPath.item].image
        
    }
    
    //一级菜单 右边带有数字
    func menu(_ menu: DOPDropDownMenu!, detailTextForRowAt indexPath: DOPIndexPath!) -> String! {
        let value  = _MenuValue[indexPath.column]
        return  value.OneMenu[indexPath.row].TowMenu.count.description  //获取二级列表的总数
    }
    //二级菜单 右边带有数字
    func menu(_ menu: DOPDropDownMenu!, detailTextForItemsInRowAt indexPath: DOPIndexPath!) -> String! {
        
        return "0"
    }
    //选择
    func menu(_ menu: DOPDropDownMenu!, didSelectRowAt indexPath: DOPIndexPath!) {
        
        let title = _MenuValue[indexPath.column]
        if(title.OneMenu[indexPath.row].TowMenu.count==0){
            //一级菜单
            //            print(title.OneMenu[indexPath.row].name)
            if(myCallbackValue != nil){
                myCallbackValue!(title.OneMenu[indexPath.row].name!,title.OneMenu[indexPath.row].value!)
            }
        }
        else{//选中二级
            if(indexPath.item>0){
                //                print(title.OneMenu[indexPath.row].TowMenu[indexPath.item].name )
                myCallbackValue!(title.OneMenu[indexPath.row].TowMenu[indexPath.item].name!,title.OneMenu[indexPath.row].TowMenu[indexPath.item].value!)
            }
        }
    }
    
    
    
}
