//
//  NextVC.swift
//  SwiftDemo
//
//  Created by Cain on 2018/12/3.
//  Copyright © 2018 JimmyKing. All rights reserved.
//

import UIKit

class NextVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    //MARK:--
    //MARK:-- 自定义打印
    func customerLog() {
        JKLog("自定义打印")
    }
    
    func JKLog(_ message: String,
               file: String = #file,
               function: String = #function,
               line: Int = #line)  {
        #if FREE_VERSION
        print("文件路径:\(file),方法名:\(function),第\(line)行:\(message)")
        #endif
    }
    
    //MARK:--
    //MARK:-- 抛异常
    func tryCatchDemo() {
        do {
            try login(user: "cain", password: "leo1")
        } catch LoginError.UserNotFound {
            print("UserNotFound")
        } catch LoginError.UserPasswordNotMatch{
            print("UserPasswordNotMatch")
        } catch {
            //加入一个空的catch，用于关闭catch。否则会报错：Errors thrown from here are not handled because the enclosing catch is not exhaustive
            print("aaa")
        }
    }
    
    enum LoginError:Error {
        case UserNotFound, UserPasswordNotMatch
    }
    
    func login(user: String, password: String) throws {
        let username = "cain", pw = "leo"
        if username != user.lowercased() {
            throw LoginError.UserNotFound
        }
        if pw != password {
            throw LoginError.UserPasswordNotMatch
        }
        print("LoginSuccessfully")
    }
    
    //MARK:--
    //MARK:-- kvo
    func kvoDemo() {
        let obj = KVOClass()
        obj.obseverObject.name = "Leo"
        obj.obseverObject.name = "Jim"
    }
    
    //MARK:--
    //MARK:-- GCD延时任务
    func GCDDelayDemo() {
        print("程序开始")
        
        _ = deally(2) {
            print("2秒后输出")
        }
    }
    
    //MARK:--
    //MARK:-- GCD取消任务
    func GCDCanelDemo() {
        let task = deally(5) {
            print("5秒后输出")
        }
        cancel(task)
    }
    
    typealias Task = (_ cancel: Bool) -> Void
    
    func deally(_ time:TimeInterval, task: @escaping ()->()) -> Task? {
        func dispatch_later (closure: @escaping ()->()){
            print("b")
            let realTime = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: realTime, execute: closure)
        }
        
        //定义一个可选值，接收闭包
        var closure: (()->Void)? = task
        var result:Task?
        let delayedClosure:Task = {
            cancel in
            print("d:cancel=\(cancel)")
            if let internalClosure = closure {
                if cancel == false {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            
            //cancel后,闭包为空了,就取消了
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        print("a")
        dispatch_later {
            //延时后执行的闭包
            print("c")
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        return result
    }
    
    func cancel(_ task: Task?) {
        task?(true)
    }
    
    //MARK:--
    //MARK:-- 条件编译
    func ifDefineDemo() {
        #if FREE_VERSION
        print("aaa")
        #else
        print("bbb")
        #endif
    }
    
    //MARK:--
    //MARK:-- 深拷贝
    func copyProtocolDemo() {
        let obj = TestClass()
        obj.num = 100
        
        let copyObj = obj.copy()
        obj.num = 10
        print(obj.num, copyObj.num)
    }
    
    //MARK:--
    //MARK:-- 便利构造方法
    func convenienceInitializeDemo() {
        let obj = ClassB(isBigNumber: true)
        print(obj.numA, obj.numB)
    }
    
    //MARK:--
    //MARK:-- 可变参数
    func mutableParameterDemo() {
        let sum = Calculator().getSum(inputNumbers: 1, 2, 3, 4, 5)
        print(sum)
        Calculator().logNumbers(numbers: 10, 1, 2, string: "hello")
    }
    
    struct Calculator {
        func getSum(inputNumbers: Int...) -> Int {
            /**
             public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result
             用于做序列元素的累加，如数组元素的累加。
             */
            return inputNumbers.reduce(0, +)
        }
        
        func logNumbers(numbers: Int..., string: String) {
            numbers.forEach { (body) in
                print("\(body): \(string)")
            }
        }
    }
    
    //MARK:--
    //MARK:-- 关联类
    func associatedtypeDemo() {
        Tiger().eat(food: Meat())
        Sheep().eat(food: Grass())
        
        let isTigerDangerous = isDangerous(animal: Tiger())
        let isSheepDangerous = isDangerous(animal: Sheep())
        print(isTigerDangerous, isSheepDangerous)
    }
    
    //MARK:--
    //MARK:-- 数组自定义下标(根据下标集合查询数组中对应的值)
    func arraySubscriptDemo() {
        var arr = ["a" ,"b", "c", "d", "e",]
        print(arr[[1, 2]])
        arr[[3, 4]] = ["z", "x"]
        print(arr)
        print(arr[0], arr[[0]])
    }
    
    //MARK:--
    //MARK:-- 字面量表达
    func literalDemo() {
        
        let t:MyBool = true
        let f:MyBool = false
        
        print(t.rawValue)
        print(f.rawValue)
        
        let url1:URL = "testurl"
        print(url1)
        //        let url2:URL = ""
        //        print(url2)
        
        let person:Person = "Cain"
        print(person.name)
        
    }
    
    //MARK:--
    //MARK:-- 方法嵌套
    func innerFuncDemo() {
        var a = 20
        makeIncrementor(addNumber: 10)(&a)
    }
    
    func makeIncrementor(addNumber: Int) -> (inout Int) -> () {
        func incrementor(variable: inout Int) -> (){
            variable += addNumber
            print(variable)
        }
        return incrementor
    }
    
    //MARK:--
    //MARK:-- 结构体
    func structDemo() {
        let v1 = Vector2D(x: 1.0, y: 2.0)
        let v2 = Vector2D(x: 3.2, y: 4.1)
        let v3 = add(left: v1, right: v2)
        print(v3)
    }
    
    func add(left:Vector2D, right:Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    
    struct Vector2D {
        var x = 0.0, y = 0.0
    }
    
    //MARK:--
    //MARK:-- autoclosure关键字使用
    func autoclosureDemo() {
        logIfTureNormal(
            {return 1 > 2}
        )
        logIfTure(2 > 1)
    }
    
    //参数是代码块
    func logIfTureNormal(_ predicate: () -> Bool) {
        if predicate() {
            print("true")
        }else{
            print("false")
        }
    }
    
    /**
     autoclosure关键字会自动把 2>1 这个表达式转换为 ()->Bool
     */
    func logIfTure(_ predicate: @autoclosure () -> Bool) {
        if predicate() {
            print("true")
        }else{
            print("false")
        }
    }
    
    //MARK:--
    //MARK:-- 多元组
    func tupleDemo() {
        var a = 1, b = 2
        swap(a: &a, b: &b)
        let rect = CGRect(x: 0, y: 0, width: 100, height: 200)
        /**
         使用多元祖接收参数
         public func divided(atDistance: CGFloat, from fromEdge: CGRectEdge) -> (slice: CGRect, remainder: CGRect)
         */
        let (small, large) = rect.divided(atDistance: 20, from: .minXEdge)
        print((small, large))
    }
    
    //交换两个变量
    func swap<T>(a: inout T, b:inout T) {
        (a, b) = (b, a)
        print(a, b)
    }
    
    //MARK:--
    //MARK:-- 泛型的使用
    func genericityDemo() {
        var stackOfStrings = Stack<String>()
        print("字符串元素入栈: ")
        stackOfStrings.push("google")
        stackOfStrings.push("runoob")
        print(stackOfStrings.items);
        
        let deletetos = stackOfStrings.pop()
        print("出栈元素: " + deletetos)
        print(stackOfStrings.items)
        
        var stackOfInts = Stack<Int>()
        print("整数元素入栈: ")
        stackOfInts.push(1)
        stackOfInts.push(2)
        print(stackOfInts.items);
    }
    
    struct Stack<Element> {
        var items = [Element]()
        mutating func push(_ item: Element) {
            items.append(item)
        }
        mutating func pop() -> Element {
            return items.removeLast()
        }
    }
    
    /**
     在Swift众多数据类型中，只有class是指针传递，其余的如Int,Float,Bool,Character,Array,Set,enum,struct全都是值传递.
     让值传递以指针方式传递
     有时候我们需要通过一个函数改变函数外面变量的值(将一个值类型参数以引用方式传递)，这时，Swift提供的inout关键字就可以实现。
     */
    //MARK:--
    //MARK:-- inout关键字
    func inoutDemo() {
        var num1 = "100"
        var num2 = "200"
        swapTwoValues(&num1, &num2)
        print(num1, num2)
    }
    
    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    //MARK:--
    //MARK:-- 修改protocol中的变量
    func protocolDemo() {
        var car = MyCar()
        car.changeColor()
        print(car.numberOfWheels)
        print(car.color)
    }
    
    struct MyCar:vehicle {
        var numberOfWheels: Int = 4
        
        var color: UIColor = .blue

        mutating func changeColor() {
            color = .red
            numberOfWheels = 8
        }
    }
    
    //MARK:--
    //MARK:-- 柯里化
    func currying() {
        let sum1 = sumWithTwoNumber(1)(2)
        let sum2 = sumWithThreeNumber(5)(10)(15)
        print(sum1, sum2)
        
        print(greaterThan(10)(13), greaterThan(20)(8))
        appendString(str1: "a")("b")
        print(datePrint(4)(11)("2018年"))
    }
    
    private let datePrint:(Int)->(Int)->(String)->String = {
        month in
        print("\(month)月")
        return{
            day in
            print("\(day)日")
            return{
                year in
                print(year)
                return year + "\(month)月" + "\(day)日"
            }
        }
    }
    
    private func sumWithTwoNumber(_ adder:Int) ->(Int) -> Int {
        return {
            num in
            num + adder
        }
    }
    
    private func sumWithThreeNumber(_ a: Int) -> (Int) -> (Int) -> Int {
        return {
            b in
            return {
                c in
                return a + b + c
            }
        }
    }
    
    private func greaterThan(_ compare: Int) -> (Int) -> Bool {
        //$0表示闭包中的第一个参数(Int)
        return { $0 > compare }
//        return { num in
//            num > compare
//        }
    }
    
    
    private func appendString(str1: String) ->(String) -> Void {
        return {
            str2 in
            let result = str1 + str2
            print(result)
        }
    }
}
