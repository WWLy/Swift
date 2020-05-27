//
//  CYTableSectionVC.swift
//  RXSwiftDemo
//
//  Created by WWLy on 2020/5/27.
//  Copyright © 2020 YY. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import KRProgressHUD

class CYCell: UITableViewCell {
    var disposeBag = DisposeBag()
}

class Ticker {
    var price: String = "0"
    
    convenience init(_ price: Double) {
        self.init()
        self.price = "\(price)"
    }
    
    func increase() {
        self.price = "\(Double(self.price)! + 1.0)"
    }
}

class CYTableSectionVC: UIViewController, UITableViewDelegate {

    private lazy var tableView: UITableView = {
        let v = UITableView(frame: CGRect(x: 0, y: 100, width: self.view.width, height: self.view.height - 130))
        v.register(CYCell.self, forCellReuseIdentifier: "Cell")
        return v
    }()
    
    var disposeBag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, BehaviorSubject<Ticker>>>(configureCell: { (_, tableView, indexPath, element) -> CYCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CYCell
        cell.disposeBag = DisposeBag()
        let _ = element.subscribe(onNext: { (ticker) in
            let price = ticker.price
            cell.textLabel?.text = "\(price) @ row \(indexPath.row)"
        }).disposed(by: cell.disposeBag)
        return cell
    }, titleForHeaderInSection: { (dataSource, sectionIndex) -> String? in
        return dataSource[sectionIndex].model
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(tableView)
    
        let items = Observable.just(
            [
                SectionModel(model: "First section", items: [BehaviorSubject(value: Ticker(1.0)), BehaviorSubject(value: Ticker(2.0)), BehaviorSubject(value: Ticker(3.0)), BehaviorSubject(value: Ticker(4.0)), BehaviorSubject(value: Ticker(5.0))]),
                SectionModel(model: "Second section", items: [BehaviorSubject(value: Ticker(1.0)), BehaviorSubject(value: Ticker(2.0)), BehaviorSubject(value: Ticker(3.0)), BehaviorSubject(value: Ticker(4.0)), BehaviorSubject(value: Ticker(5.0))]),
                SectionModel(model: "Third section", items: [BehaviorSubject(value: Ticker(1.0)), BehaviorSubject(value: Ticker(2.0)), BehaviorSubject(value: Ticker(3.0)), BehaviorSubject(value: Ticker(4.0)), BehaviorSubject(value: Ticker(5.0))]),
                SectionModel(model: "Forth section", items: [BehaviorSubject(value: Ticker(1.0)), BehaviorSubject(value: Ticker(2.0)), BehaviorSubject(value: Ticker(3.0)), BehaviorSubject(value: Ticker(4.0)), BehaviorSubject(value: Ticker(5.0))])
            ]
        )
        
        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.map { (indexPath) in
            return (indexPath, self.dataSource[indexPath])
        }.subscribe(onNext: { (pair) in
            pair.1.onNext(Ticker(12))
        }).disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
