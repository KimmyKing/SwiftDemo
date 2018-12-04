//
//  ViewController.swift
//  SwiftDemo
//
//  Created by Cain on 2018/4/24.
//  Copyright © 2018年 JimmyKing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
}
    
    lazy var tableView:UITableView = {
       let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        return tableView
    }()
    
    let dataArr: [String] = [
        "柯里化",
        "修改protocol中的变量",
        "让值传递以指针方式传递",
        "泛型的使用",
        "多元组",
        "autoclosure关键字使用",
        "结构体",
        "方法嵌套",
        "字面量表达",
        "数组自定义下标(根据下标集合查询数组中对应的值)",
        "关联类",
        "可变参数",
        "便利构造方法",
        "深拷贝",
        "条件编译",
        "GCD延时任务",
        "GCD取消任务",
        "kvo",
        "抛异常",
        "自定义打印",
    ]
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NextVC()
        switch indexPath.row {
        case 0:
            vc.currying()
        case 1:
            vc.protocolDemo()
        case 2:
            vc.inoutDemo()
        case 3:
            vc.genericityDemo()
        case 4:
            vc.tupleDemo()
        case 5:
            vc.autoclosureDemo()
        case 6:
            vc.structDemo()
        case 7:
            vc.innerFuncDemo()
        case 8:
            vc.literalDemo()
        case 9:
            vc.arraySubscriptDemo()
        case 10:
            vc.associatedtypeDemo()
        case 11:
            vc.mutableParameterDemo()
        case 12:
            vc.convenienceInitializeDemo()
        case 13:
            vc.copyProtocolDemo()
        case 14:
            vc.ifDefineDemo()
        case 15:
            vc.GCDDelayDemo()
        case 16:
            vc.GCDCanelDemo()
        case 17:
            vc.kvoDemo()
        case 18:
            vc.tryCatchDemo()
        case 19:
            vc.customerLog()
        default:
            break
        }
        vc.title = dataArr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
