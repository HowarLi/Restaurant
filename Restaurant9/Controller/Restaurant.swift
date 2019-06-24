//
//  Restaurant.swift
//  FoodPin
//
//  Created by 李浩綸 on 2018/7/3.
//  Copyright © 2018年 李浩綸. All rights reserved.
//

import Foundation
class  Restaurant{
    var name:String
    var type:String
    var location:String
    var phone:String
    var image:String
    var isVisited = false
    var rating = ""
    
    init(name:String, type:String, location:String ,phone:String, image:String, isVisited:Bool){
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.image = image
        self.isVisited = isVisited
    }
    
    convenience init(){
        self.init(name:"", type:"", location:"",phone:"", image:"", isVisited:false)
    }
    
}
