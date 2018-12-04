//
//  ProtocolTest.swift
//  SwiftDemo
//
//  Created by Cain on 2018/4/25.
//  Copyright © 2018年 JimmyKing. All rights reserved.
//

import Foundation
import UIKit

//MARK:--
//MARK:-- 定义一个协议,限制调用协议方法的对象和返回的对象是同一类型
protocol Copyable {
    func copy() -> Self
}

class TestClass: Copyable {
    var num = 1
    
    func copy() -> Self {
        let result = type(of: self).init()
        result.num = num
        return result
    }
    
    required init () {
    }
}

//MARK:--
//MARK:-- associatedtype
protocol Food {
}

protocol Animal {
    //关联类,这里就不关心F的具体类型,只需要满足协议中F和eat参数的一致即可
    associatedtype F:Food
    func eat(food:F)
}

struct Grass:Food {
}

struct Meat:Food {
}

struct Tiger:Animal {
    func eat(food: Meat) {
        print("eat meat")
    }
}
    
struct Sheep:Animal {
    func eat(food: Grass) {
        print("eat grass")
    }
}

func isDangerous<T: Animal>(animal: T) -> Bool {
    if animal is Tiger {
        return true
    }else{
        return false
    }
}

//MARK:--
//MARK:-- 修改协议中声明的变量
protocol vehicle {
    //代理必须初始化协议中的变量(声明的时候或者构造代理的时候)
    var numberOfWheels:Int{get}
    var color:UIColor {get}
    
    //mutating:表示这个函数中可以修改协议中声明的变量
    mutating func changeColor()
}
