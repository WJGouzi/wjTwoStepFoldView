//
//  ViewController.swift
//  wjTwoStepFoldView
//
//  Created by gouzi on 2017/8/1.
//  Copyright © 2017年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.wjUISetUp()
    }
    
    /// 创建UI界面
    func wjUISetUp() {
        // 创建标题
        self.title = "主页"
        
        let btn = UIButton(frame: CGRect(x: 50, y: 200, width: 100, height: 30))
        btn.backgroundColor = UIColor.red
        btn.setTitle("点击进入到下一页", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(ViewController.btnAction(_ :)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btn)
    }
 
    // 按钮的点击事件
    func btnAction(_ btn : UIButton) {
        print("点击了")
        let wjFold = wjFoldVC()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(wjFold, animated: true)
    }
}

