//
//  StudyPlanController.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/2/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class StudyPlanController: UIViewController, UIScrollViewDelegate {

    var tabsSelectView: TabsSelectView!
    var vcScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let contentOffset = scrollView.contentOffset
        let scrollFrame = scrollView.frame
        let page = contentOffset.x / scrollFrame.size.width
        print("scrollViewDidEndDecelerating page ==", page)
        self.tabsSelectView.updateButtonState(tag: Int(page))
    }

    func letItScroll(tag: Int) {
        let scrollWidth = self.vcScrollView.frame.size.width
        self.vcScrollView.setContentOffset(CGPoint(x: scrollWidth * CGFloat(tag), y: 0), animated: true)
    }

    func setupViews() {

        let imageNormalArray = [
            "message_notificationNomal",
            "message_responseNormal",
            "message_zanNormal",
        ]
        let imageSelectArray = [
            "message_notificationSeleted",
            "message_responseSelected",
            "message_zanSelected",
        ]
        tabsSelectView = TabsSelectView.init(frame: CGRect.zero, selectImageArray: imageSelectArray, normalImageArray: imageNormalArray)
        self.view.addSubview(tabsSelectView)
        tabsSelectView.snp.makeConstraints { make in
            make.top.left.right.equalTo(0)
            make.height.equalTo(40)
        }
        tabsSelectView.clickButtonBlock = { (tag: Int) in
            print("in controller,click button,the tag is \(tag)")
            self.letItScroll(tag: tag)
        }

        vcScrollView = UIScrollView.init()
        vcScrollView.showsHorizontalScrollIndicator = false
        vcScrollView.isPagingEnabled = true
        vcScrollView.delegate = self
        vcScrollView.bounces = false
        self.view.addSubview(vcScrollView)
        vcScrollView.snp.makeConstraints { make in
            make.top.equalTo(tabsSelectView.snp.bottom)
            make.bottom.right.left.equalTo(0)
        }

        let containerView = UIView.init()
        vcScrollView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(vcScrollView)
            make.width.greaterThanOrEqualTo(vcScrollView)
            make.height.equalTo(vcScrollView.snp.height)
        }

        let haVC = HomeAllController()
        let hsVC = HomeStudyingController()
        let hnsVC = HomeNotStartController()

        self.addChildViewController(haVC)
        self.addChildViewController(hsVC)
        self.addChildViewController(hnsVC)

        containerView.addSubview(haVC.view)
        containerView.addSubview(hsVC.view)
        containerView.addSubview(hnsVC.view)

        haVC.view.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(vcScrollView.snp.width)
        }
        hsVC.view.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.width.equalTo(vcScrollView.snp.width)
            make.left.equalTo(haVC.view.snp.right)
        }
        hnsVC.view.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.width.equalTo(vcScrollView.snp.width)
            make.left.equalTo(hsVC.view.snp.right)
            make.right.equalTo(containerView.snp.right)
        }
    }
}
