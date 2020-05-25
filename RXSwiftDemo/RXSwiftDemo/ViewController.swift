//
//  ViewController.swift
//  RXSwiftDemo
//
//  Created by WWLy on 2020/5/21.
//  Copyright © 2020 YY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {

    private lazy var usernameTF: UITextField = {
        let tf = UITextField(frame: CGRect(x: 30, y: 100, width: self.view.width - 60, height: 40))
        tf.backgroundColor = .lightGray
        return tf
    }()
    
    private lazy var usernameValidTip: UILabel = {
        let label = UILabel(text: "长度不能小于 5", font: UIFont.systemFont(ofSize: 12), textColor: .gray)
        label.frame = CGRect(x: self.usernameTF.x, y: self.usernameTF.maxY + 20, width: self.usernameTF.width, height: 30)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        
        view.addSubviews([usernameTF, usernameValidTip])
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        test3()
        
        // 可监听序列
        // Single: 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能发出一个元素，要么产生一个 error 事件
        // Completable: 要么只能产生一个 completed 事件，要么产生一个 error 事件, 适用于那种你只关心任务是否完成，而不需要在意任务返回值的情况。和 Observable<Void> 有点相似
        // Maybe: 要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件。
        // Driver: 主要是为了简化 UI 层的代码。
        //          不会产生 error 事件
        //          一定在 MainScheduler 监听（主线程监听）
        //          共享附加作用
        // Signal: 和 Driver 类似, 但是 Driver 会对观察者发送上一个元素, 而 Signal 不会
        //          一般情况下状态序列我们会选用 Driver 这个类型，事件序列我们会选用 Signal 这个类型。
        // ControlEvent: 专门用于描述 UI 控件所产生的事件
        //          不会产生 error 事件
        //          一定在 MainScheduler 订阅（主线程订阅）
        //          一定在 MainScheduler 监听（主线程监听）
        //          共享附加作用
        
        
        // 观察者
        // AnyObserver: 可以描述任意一种观察者
        // Binder: 不会处理错误事件, 确保绑定都是在给定 Scheduler 上执行, 默认是 MainScheduler
        //          一旦产生错误事件, 在调试环境下将执行 fatalEror, 在发布环境下将打印错误信息
        
        
        // 既是观察者又是监听者
        // AsyncSubject: 将在源 Observable 产生完成事件后，发出最后一个元素 (完成事件也会发送), 如果发生错误, 则只发送 error
        // 
        
        
        getRepo("").subscribe(onSuccess: { (json) in
            // 在这里创建观察者
            
        }) { (error) in
            
        }
        
    }
    
    func getRepo(_ repo: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create { single in
            let url = URL(string: "https://api.github.com/repos/\(repo)")!
            let task = URLSession.shared.dataTask(with: url) {
                data, _, error in

                if let error = error {
                    single(.error(error))
                    return
                }

                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                      let result = json as? [String: Any] else {
                    single(.error(error!))
                    return
                }

                single(.success(result))
            }

            task.resume()

            return Disposables.create { task.cancel() }
        }
    }
    
    func create() {
        let disposeBag = DisposeBag()
        typealias JSON = Any
        let json: Observable<JSON> = Observable.create { (observer) -> Disposable in
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: "")!)) { (data, _, error) in
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                
                guard let data = data,
                    let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    else {
                        // 这里单纯为了编译通过
                    observer.onError(error!)
                    return
                }
                
                observer.onNext(jsonObject)
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
        
        json.subscribe(onNext: { (json) in
            print("成功获取 json: \(json)")
        }, onError: { (error) in
            print("获取 json 失败: \(error)")
        }, onCompleted: {
            print("获取 json 任务完成")
        }) {
            print("解除")
        }.disposed(by: disposeBag)
    }
    
    
    func test3() {
//        Observable - 产生事件
//        Observer - 响应事件
//        Operator - 创建变化组合事件
//        Disposable - 管理绑定（订阅）的生命周期
//        Schedulers - 线程队列调配
        
        // Observable<String>
        let text = usernameTF.rx.text.orEmpty.asObservable()
        // Observer<Bool>
        let usernameValid = text
            // Operator
            .map { $0.count >= 5 }
        
        // Observer<Bool>
        let observer = usernameValidTip.rx.isHidden
        
        let disposable = usernameValid
            // Scheduler 用于控制任务在哪个线程队列运行
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .bind(to: observer)
        
        // 可以在页面退出的时候取消监听
        disposable.dispose()
        
        
        let _observer: Binder<Bool> = Binder(usernameValidTip) { (view, isHidden) in
            view.isHidden = isHidden
        }
        usernameValid.bind(to: _observer).disposed(by: DisposeBag())
    }
    
    func test2() {
        let disposeB = DisposeBag()
        
        let subject = BehaviorRelay(value: "first")
        subject.accept("++second")
        subject.accept("second")
        subject.asObservable().subscribe(onNext: { (event) in
            print(event)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Variber订阅完成")
        }) {
            print("Variber销毁")
        }
        .disposed(by: disposeB)
        
        subject.accept("third")
    }
    
    func test1() {
        let disposeB = DisposeBag()
        
        let subject = BehaviorSubject(value: "first signal")
        subject.onNext("another first signal") //会替换了 first signal 的信号
        subject.subscribe(onNext: { (event) in
            print(event)
        } , onCompleted: {
            print("completed")
        }) {
            print("第一个销毁了")
        }.disposed(by: disposeB)
        
        subject.onNext("second signal")

        subject.onNext("third signal") //这里试图替换上面的 second signal 的event
        subject.subscribe(onNext: { (event) in
            print(event)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("completed")
        }) {
            print("第二个销毁了")
        }.disposed(by: disposeB)
        
        subject.onError(NSError(domain: "myError", code: 10010, userInfo: ["myUserInfo":"10010错误"]))
    }
    
    func test() {
        let disposeB = DisposeBag()
        
        let subject = PublishSubject<String>()
        subject.onNext("first signal")
        subject.subscribe(onNext: { (event) in
            print("first event is"+event)
        }, onCompleted: {
            print("completed first")
        }) {
            print("first :销毁了")
        }.disposed(by: disposeB)
        
        subject.onNext("second signal")
        subject.subscribe(onNext: { (event) in
            print("second event is "+event)
        }, onCompleted: {
            print("completed second")
        }) {
            print("second :销毁了")
        }.disposed(by: disposeB)
        
        //让subject结束,后面再进行订阅
        subject.onCompleted()
        
        subject.onNext("third signal")
        subject.onNext("fourth signal")
        subject.subscribe(onNext: { (event) in
            print("this is another"+event)
        }, onCompleted: {
            print("completed another")
        }) {
            print("another :销毁了")
        }.disposed(by: disposeB)
    }
}



// 观察者复用
// 也可以用这种方式来创建自定义的 UI 观察者
extension Reactive where Base: UIView {
  public var isHidden: Binder<Bool> {
      return Binder(self.base) { view, hidden in
          view.isHidden = hidden
      }
  }
}

extension Reactive where Base: UILabel {
  public var text: Binder<String?> {
      return Binder(self.base) { label, text in
          label.text = text
      }
  }
}
