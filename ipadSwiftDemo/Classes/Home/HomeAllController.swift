//
//  HomeAllController.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/2.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class HomeAllController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dataSourceArray: Array<String>!
    var tableView: UITableView!
    var curve: CurveView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        initData()
        setupViews()
    }

    func initData() {

        curve = CurveView.init(frame: .zero)
        self.view.addSubview(curve)
        curve.snp.makeConstraints { make in
            make.top.right.left.equalTo(0)
            make.height.equalTo(curveMaxHeight / 2)
        }

        dataSourceArray = [
            "发如雪",
            "东风破",
            "珊瑚海",
            "青花瓷",
            "七里香",
            "千里之外",
            "红尘客栈",
            "外婆",
            "听妈妈的话",
            "琴伤",
            "飘逸",
            "皮影戏",
            "白色风车",
            "晴天",
            "彩虹",
            "稻香",
            "枫",
            "鞋子特大号",
            "借口",
            "暗号",
        ]
    }

    func setupViews() {
        tableView = UITableView.init()
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(curve.snp.bottom)
        }

        tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

        if keyPath == "contentOffset" {
            let currentPoint = self.tableView.contentOffset
            var currentY: CGFloat = currentPoint.y
            if currentY > curveMaxHeight {
                currentY = curveMaxHeight
            } else if currentY < 0 {
                currentY = 0
            }
            currentY = curveMaxHeight - currentY
            self.curve.updateMaxHeight(thisHeight: currentY)
            curve.snp.remakeConstraints({ make in
                make.top.left.right.equalTo(0)
                make.height.equalTo(currentY / 2)
            })
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return self.dataSourceArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeAllViewCellTableViewCell = HomeAllViewCellTableViewCell.cellWithTableView(tableView: tableView) as! HomeAllViewCellTableViewCell
        cell.updateContent(songName: self.dataSourceArray[indexPath.row])
        return cell
    }

    deinit {
        self.tableView.removeObserver(self, forKeyPath: "contentOffset")
    }
}
