//
//  ViewController.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/2/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

    var userView: UserAreaView!
    var leftListRootView: LeftListRootView!
    var titleLabel: UILabel!
    var titlesArray: Array<String>!
    var containerView: UIView!
    var viewsArray: Array<UIView>!
    var currentView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        addAllControllers()
        makeUserAreaView()
        makeLeftListRootView()
        makeContainerView()

        assert(titlesArray.count == viewsArray.count, "two array count must be equal")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addAllControllers() {
        let homeVC = HomeController()
        let studyVC = StudyPlanController()
        let liveVC = LiveController()
        let exerciseVC = ExerciseController()
        let modelVC = ModelExamController()
        let checkVC = CheckController()
        let teachVC = BrieflyTeachController()

        self.addChildViewController(homeVC)
        self.addChildViewController(studyVC)
        self.addChildViewController(liveVC)
        self.addChildViewController(exerciseVC)
        self.addChildViewController(modelVC)
        self.addChildViewController(checkVC)
        self.addChildViewController(teachVC)

        viewsArray = [
            homeVC.view,
            studyVC.view,
            liveVC.view,
            exerciseVC.view,
            modelVC.view,
            checkVC.view,
            teachVC.view,
        ]
    }

    func makeContainerView() {
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.colorWithRGB(red: 66, green: 66, blue: 66)
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        self.view.addSubview(titleLabel)
        self.titleLabel.text = self.titlesArray[0]
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.bottom).offset(20)
            make.left.equalTo(leftListRootView.snp.right).offset(20)
        }
        containerView = UIView()
        self.view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(leftListRootView.snp.right).offset(20)
            make.right.bottom.equalTo(-20)
        }
        currentView = self.viewsArray[0]
        containerView.addSubview(currentView!)
        currentView?.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(0)
        }
    }

    func makeLeftListRootView() {
        titlesArray = [
            "我的首页",
            "我的学习计划",
            "我的直播",
            "我的练习",
            "我的模考",
            "我的批改",
            "我的逐题精讲",
        ]
        leftListRootView = LeftListRootView(titlesArray: titlesArray, frame: CGRect.zero)
        self.view.addSubview(leftListRootView)
        leftListRootView.clickButtonBlock = { (tag: Int) in
            print("in controller,click button,the tag is \(tag)")
            self.titleLabel.text = self.titlesArray[tag]
            if self.currentView != nil {
                self.currentView?.removeFromSuperview()
            }
            self.currentView = self.viewsArray[tag]
            self.containerView.addSubview(self.currentView!)
            self.currentView?.snp.makeConstraints { make in
                make.top.left.bottom.right.equalTo(0)
            }
        }
        leftListRootView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(userView.snp.bottom).offset(20)
            make.width.equalTo(170)
        }
    }

    func makeUserAreaView() {
        userView = UserAreaView(frame: CGRect.zero)
        self.view.addSubview(userView)
        userView.signUpBlock = {
            print("in controller clickSignButton")
        }
        userView.vacateBlock = {
            print("in controller clickVacateButton")
        }
        userView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(200)
        }
    }
}
