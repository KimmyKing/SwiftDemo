//
//  Array+Extension.swift
//  SwiftDemo
//
//  Created by Cain on 2018/4/26.
//  Copyright © 2018年 JimmyKing. All rights reserved.
//

import Foundation

/**
 自定义索引下标
 */
extension Array {
    subscript(inputIndexs: [Int]) -> ArraySlice<Element> {
        get{
            var result = ArraySlice<Element>()
            for i in inputIndexs {
                assert( i < self.count, "index outof range")
                result.append(self[i])
            }
            return result
        }
        
        set{
            //index是传递的值集合的下标,i是需要查询的下标
            for (index, i) in inputIndexs.enumerated() {
                assert(i < self.count, "index outof range")
                //newValue:传递的值集合["z", "x"]
                self[i] = newValue[index]
            }
        }
    }
}
