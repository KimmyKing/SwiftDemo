//
//  TestKVO.swift
//  SwiftDemo
//
//  Created by Cain on 2018/4/29.
//  Copyright © 2018年 JimmyKing. All rights reserved.
//

import Foundation

class ObserveClass: NSObject {
    @objc dynamic var name:String = "Cain"
}

class KVOClass: NSObject {
    
    var obseverObject: ObserveClass!
    var observation: NSKeyValueObservation?
    
    override init() {
        super.init()
        obseverObject = ObserveClass()
        observation = obseverObject.observe(\.name, options: NSKeyValueObservingOptions.new, changeHandler: { (obj , change) in
            print(change)
        })
    }
}
