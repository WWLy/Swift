//
//  CYImagePickerVC.swift
//  RXSwiftDemo
//
//  Created by WWLy on 2020/5/27.
//  Copyright © 2020 YY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CYImagePickerVC: UIViewController {

    private lazy var selectButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        btn.backgroundColor = .red
        return btn
    }()
    
    private lazy var imageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 100, y: 350, width: 100, height: 100))
        imgView.backgroundColor = .gray
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubviews([selectButton, imageView])
        
//        selectButton.rx.tap.flatMapLatest {[weak self] (Void) -> Observable<[UIImagePickerController.InfoKey : AnyObject]>  in
//            return UIImagePickerController.rx.createWithParent(self) { (picker) in
//                picker.sourceType = .camera
//                picker.allowsEditing = false
//            }.flatMap { (picker) -> Observable<[String : AnyObject]> in
//                picker.rx.didFinishPickingMediaWithInfo
//            }.take(1)
//        }
        
        selectButton.rx.tap
        .flatMapLatest { [weak self] _ in
            return UIImagePickerController.rx.createWithParent(self) { picker in
                picker.sourceType = .photoLibrary
                picker.allowsEditing = false
            }
            .flatMap {
                $0.rx.didFinishPickingMediaWithInfo
            }
            .take(1)
        }
        .map { info in
            return info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
        }
        .bind(to: imageView.rx.image)
        .disposed(by: disposeBag)
        
    }
    
}


func dismissViewController(_ viewController: UIViewController, animated: Bool) {
    if viewController.isBeingDismissed || viewController.isBeingPresented {
        DispatchQueue.main.async {
            dismissViewController(viewController, animated: animated)
        }

        return
    }

    if viewController.presentingViewController != nil {
        viewController.dismiss(animated: animated, completion: nil)
    }
}

extension Reactive where Base: UIImagePickerController {

    /**
     Reactive wrapper for `delegate` message.
     */
    public var didFinishPickingMediaWithInfo: Observable<[String : AnyObject]> {
        return delegate
            .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:)))
            .map({ (a) in
                return try self.castOrThrow(Dictionary<String, AnyObject>.self, a[1])
            })
    }
    
    private func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
        guard let returnValue = object as? T else {
            throw RxCocoaError.castingError(object: object, targetType: resultType)
        }

        return returnValue
    }

    /**
     Reactive wrapper for `delegate` message.
     */
    public var didCancel: Observable<()> {
        return delegate
            .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerControllerDidCancel(_:)))
            .map {_ in () }
    }
    
}

extension Reactive where Base: UIImagePickerController {
    static func createWithParent(_ parent: UIViewController?, animated: Bool = true, configureImagePicker: @escaping (UIImagePickerController) throws -> Void = { x in }) -> Observable<UIImagePickerController> {
        return Observable.create { [weak parent] observer in
            let imagePicker = UIImagePickerController()
            let dismissDisposable = imagePicker.rx
                .didCancel
                .subscribe(onNext: { [weak imagePicker] _ in
                    guard let imagePicker = imagePicker else {
                        return
                    }
                    dismissViewController(imagePicker, animated: animated)
                })
            
            do {
                try configureImagePicker(imagePicker)
            }
            catch let error {
                observer.on(.error(error))
                return Disposables.create()
            }

            guard let parent = parent else {
                observer.on(.completed)
                return Disposables.create()
            }

            parent.present(imagePicker, animated: animated, completion: nil)
            observer.on(.next(imagePicker))
            
            return Disposables.create(dismissDisposable, Disposables.create {
                    dismissViewController(imagePicker, animated: animated)
                })
        }
    }
}
