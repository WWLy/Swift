//
//  CYTableVC.swift
//  RXSwiftDemo
//
//  Created by WWLy on 2020/5/27.
//  Copyright © 2020 YY. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import KRProgressHUD

class CYTableVC: UIViewController {

    private lazy var tableView: UITableView = {
        let v = UITableView(frame: CGRect(x: 0, y: 100, width: self.view.width, height: self.view.height - 130))
        v.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return v
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        let items = Observable.just(
            (0..<20).map {
                "\($0)"
            }
        )
        
        items.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, element, cell in
            cell.textLabel?.text = "\(element) @ row \(row)"
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self).subscribe(onNext: { (value) in
//            KRProgressHUD.showMessage(value)
            }).disposed(by: disposeBag)
        
        tableView.rx.itemAccessoryButtonTapped.subscribe(onNext: { (index) in
            KRProgressHUD.showMessage("\(index.row)")
            }).disposed(by: disposeBag)
    }


}
