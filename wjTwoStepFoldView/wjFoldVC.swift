//
//  wjFoldVC.swift
//  wjTwoStepFoldView
//
//  Created by gouzi on 2017/8/1.
//  Copyright © 2017年 wj. All rights reserved.
//

import UIKit

class wjFoldVC: UITableViewController {

    /// 声明一些属性
    // 存放的数据源
    var dateFileArray : NSMutableArray!
    // 存放文件类型的数据源
    var fileCataglogueArray : NSMutableArray!
    // 单个文件数据源
    var singleFileArray : NSMutableArray!
    
    
    
    // MARK:- 声明周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wjUISetUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        // 创建数据
        self.wjCreatData()
    }
    
    func wjCreatData() {
        self.dateFileArray = NSMutableArray()
        self.fileCataglogueArray = NSMutableArray()
        self.singleFileArray = NSMutableArray()
        
        let a = 1, i = 1, j = 0
        
        for _ in a...5 {
            for i in i..<5 {
                let marr = NSMutableArray()
                for j in j..<5 {
                    marr.add("\(i) : \(j)")
                }
                self.singleFileArray.add(marr)
                // 存放折叠的状态
                self.fileCataglogueArray.add(true)
            }
            self.dateFileArray.add(true)
        }
        print(self.singleFileArray)
    }
    
    
    // 创建UI界面
    func wjUISetUp() {
        self.title = "二级菜单"
//        self.tableView.tableFooterView = UIView()
    }
    
}

// MARK: - Table view data source
extension wjFoldVC {
    // sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dateFileArray.count
    }
    
    // raws
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.fileCataglogueArray[section] as! Bool == true {
            if self.dateFileArray[section] as! Bool == true {
                return 0
            }
            let sectionCount = self.fileCataglogueArray[section]
            return (sectionCount as AnyObject).count
        }
        
        return (self.singleFileArray[section] as AnyObject).count
    }
 
    // cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iden = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: iden)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: iden)
        }
        let cellArray = self.singleFileArray[indexPath.section] as! NSArray
        
        cell?.textLabel?.text = cellArray[indexPath.row] as? String

        return cell!
    }
}


// MARK:- tableView delegate
extension wjFoldVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click cell is \(indexPath.section) : \(indexPath.row) : \(String(describing: tableView.cellForRow(at: indexPath)?.textLabel?.text))")
    }
    // 标题头的高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // 定义标题头
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let btn = UIButton(type: .custom)
        
        btn.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
        btn.backgroundColor = UIColor.white
        let i = 1
        btn.setTitle("标题 : \(i + section)", for: .normal)
        btn.addTarget(section, action: #selector(wjFoldVC.btnAction(_ :)), for: .touchUpInside)
        btn.titleLabel?.textAlignment = .left
        btn.setTitleColor(UIColor.black, for: .normal)
        // 设置文本框在按钮中的偏移
        let btnLabelStr = btn.titleLabel?.text!
        let btnLabelW = btnLabelStr?.size(attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15.0)]).width        
        let edgeSize = self.view.frame.size.width - 22 * 2 - btnLabelW!
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -edgeSize , bottom: 0, right: 0)
        // 设置tag值
        btn.tag = section
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        view.addSubview(btn)
        
        let line = UIView(frame: CGRect(x: 16, y: 44, width: self.view.frame.size.width - 16, height: 0.5))
        line.backgroundColor = UIColor(red: 198 / 255.0, green: 197 / 255.0, blue: 202 / 255.0, alpha: 1.0)
        view.addSubview(line)
        
        return view
    }
    
    func btnAction(_ btn : UIButton) {
        // <1>获取点击之前的状态
        let isClose = self.fileCataglogueArray[btn.tag] as! Bool
        // <2>更改状态
        self.fileCataglogueArray.replaceObject(at: btn.tag, with: !isClose)
        // <3>刷新数据
        let indexSet = NSIndexSet(index: btn.tag) as IndexSet
        self.tableView.reloadSections(indexSet, with: UITableViewRowAnimation.automatic)
    }

}









