//
//  ViewController.swift
//  header
//
//  Created by WWLy on 2020/5/18.
//  Copyright © 2020 YY. All rights reserved.
//

import UIKit

class Header: UIView {
    lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
//        label.setContentCompressionResistancePriority(.required, for: .horizontal)
//        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview().priority(.required)
            make.height.greaterThanOrEqualTo(80).priority(.required)
            make.bottom.equalToSuperview().priority(.required)
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview != nil {
            snp.remakeConstraints { (make) in
                make.width.equalToSuperview()
                make.left.equalToSuperview()
            }
            layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {

    private lazy var header: Header = {
        let v = Header(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
//        v.setNeedsLayout()
//        v.layoutIfNeeded()
        return v
    }()
    
    private lazy var tableView: UITableView = {
        let v = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header.backgroundColor = .blue
        
        tableView.tableHeaderView = header
        tableView.backgroundColor = .gray
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        header.label.text = "在写代码前需要了解NSLayoutConstraint的作用,本文我门使用的NSLayoutConstraint的init方法(建议使用init方法写代码前需要了解N写代码前需要了解N写代码前需要了解N写代码前需要了解N"
        header.setNeedsLayout()
        header.layoutIfNeeded()
        
//        tableView.tableHeaderView = header
        
//        let size = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
//        header.frame = CGRect(x: header.frame.origin.x, y: header.frame.origin.y, width: header.frame.size.width, height: size.height)
    }

//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//
//        header.setNeedsLayout()
//        header.layoutIfNeeded()
//
//    }
    
}

