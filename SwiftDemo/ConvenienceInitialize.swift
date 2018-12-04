//
//  TestInitialize.swift
//  SwiftDemo
//
//  Created by Cain on 2018/4/27.
//  Copyright © 2018年 JimmyKing. All rights reserved.
//

import Foundation

//MARK:--自定义初始化
class ClassA {
    let numA: Int
    
    init(number: Int) {
        numA = number
    }
    
    /*
     convenience:便利，使用convenience修饰的构造函数叫做便利构造函数
     便利构造函数通常用在对系统的类进行构造函数的扩充时使用。
     便利构造函数的特点：
     1、便利构造函数通常都是写在extension里面
     2、便利函数init前面需要加载convenience
     3、在便利构造函数中需要明确的调用self.init()
     */
    convenience init(isBigNumber: Bool){
        self.init(number: isBigNumber ? 10000 : 1)
    }
}

class ClassB:ClassA {
    let numB: Int
    
    override init(number: Int) {
        numB = number + 1
        super.init(number: number)
    }
}
