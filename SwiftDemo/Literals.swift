//
//  CustomEnum.swift
//  SwiftDemo
//
//  Created by Cain on 2018/4/26.
//  Copyright © 2018年 JimmyKing. All rights reserved.
//

/**
 字面量表达
 */
import Foundation

//MARK:--
//MARK:-- 直接通过赋值字符串给Person类的nmae属性来构造Person对象
class Person: ExpressibleByStringLiteral {

    let name: String

    init(name value:String) {
        self.name = value
    }

    required init(stringLiteral value: String) {
        self.name = value
    }

    required init(unicodeScalarLiteral value: String) {
        self.name = value
    }

    required init(extendedGraphemeClusterLiteral value: String) {
        self.name = value
    }
}

//MARK:--
//MARK:-- 直接赋值字符串给URL来创建URL对象
extension URL:ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        if value.count > 0 {
            self = URL(string: value) ?? ""
        }else{
            preconditionFailure("This URL(\(value)) is invalid")
        }
    }
}

enum MyBool:Int {
    case myTrue, myFalse
}

extension MyBool: ExpressibleByBooleanLiteral {
    init(booleanLiteral value: Bool) {
        self = value ? .myTrue : .myFalse
    }
}
