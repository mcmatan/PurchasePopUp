//
//  PurchasePopUpManager.swift
//  PurchasePopUp
//
//  Created by Matan Cohen on 2/27/18.
//  Copyright © 2018 Matan. All rights reserved.
//

import Foundation

import UIKit

open class PurchasePopUpPresentor: UIView {
    
    open var fontSize: CGFloat = 25.0
    
    /**
     The custom label to use with the picker.
     
     ```
     let customLabel = UILabel()
     customLabel.textAlignment = .center
     customLabel.textColor = .white
     customLabel.font = UIFont(name:"American Typewriter", size: 30)!
     
     purchasePopUpPresentor.label = customLabel // Set your custom label
     ```
     */
    open var label: UILabel?
    
    public var toolbarButtonsColor: UIColor? {
        didSet {
            applyToolbarButtonItemsSettings { (barButtonItem) in
                barButtonItem.tintColor = toolbarButtonsColor
            }
        }
    }
    
    public var toolbarCancelButtonColor: UIColor? {
        didSet {
            applyToolbarButtonItemsSettings(withAction: #selector(PurchasePopUpPresentor.cancel)) { (barButtonItem) in
                barButtonItem.tintColor = toolbarCancelButtonColor
            }
        }
    }
    public var toolbarBarTintColor: UIColor? {
        didSet { toolbar.barTintColor = toolbarBarTintColor }
    }
    public var toolbarItemsFont: UIFont? {
        didSet {
            applyToolbarButtonItemsSettings { (barButtonItem) in
                //                barButtonItem.setTitleTextAttributes([.font: toolbarItemsFont!], for: .normal)
            }
        }
    }
    
    internal var popOverContentSize: CGSize {
        return CGSize(width: Constant.pickerHeight + Constant.toolBarHeight, height: Constant.pickerHeight + Constant.toolBarHeight)
    }

    internal let backgroundView: UIView = UIView()
    internal let toolbar: UIToolbar = UIToolbar()
    internal var isPopoverMode = false
    internal let contentView: UIView
    internal let title: String
    internal var purchasePopUpViewController: PurchasePopUpViewController?
    internal enum AnimationDirection {
        case `in`, out // swiftlint:disable:this identifier_name
    }

    fileprivate var cancelHandler:() -> Void = { }
    
    private var appWindow: UIWindow {
        guard let window = UIApplication.shared.keyWindow else {
            debugPrint("KeyWindow not set. Returning a default window for unit testing.")
            return UIWindow()
        }
        return window
    }
    
    private enum Constant {
        static let pickerHeight: CGFloat = 276.0
        static let toolBarHeight: CGFloat = 44.0
        static let backgroundAlpha: CGFloat =  0.75
        static let animationSpeed: TimeInterval = 0.25
        static let barButtonFixedSpacePadding: CGFloat = 0.04
    }
    
    init(contentView: UIView, title: String) {
        self.contentView = contentView
        self.title = title
        super.init(frame: .zero)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Show
    //
    open class func show(contentView: UIView, title: String, cancelHandler:@escaping () -> Void) {
        PurchasePopUpPresentor(contentView: contentView, title: title).show(cancelHandler: cancelHandler)
    }
    
    private func show(cancelHandler:@escaping () -> Void) {
        self.cancelHandler = cancelHandler
        animateViews(direction: .in)
    }
  
    open func setToolbarItems(items: [PurchasePopUpBarButtonItem]) {
        toolbar.items = items
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        if newWindow != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(PurchasePopUpPresentor.sizeViews), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        } else {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        }
    }
    
    @objc internal func sizeViews() {
        let size = isPopoverMode ? popOverContentSize : self.appWindow.bounds.size
        self.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        let backgroundViewY = isPopoverMode ? 0 : self.bounds.size.height - (Constant.pickerHeight + Constant.toolBarHeight)
        backgroundView.frame = CGRect(x: 0, y: backgroundViewY, width: self.bounds.size.width, height: Constant.pickerHeight + Constant.toolBarHeight)
        toolbar.frame = CGRect(x: 0, y: 0, width: backgroundView.bounds.size.width, height: Constant.toolBarHeight)
        self.contentView.frame = CGRect(x: 0, y: toolbar.bounds.size.height, width: backgroundView.bounds.size.width, height: Constant.pickerHeight)
    }
    
    internal func addAllSubviews() {
        backgroundView.addSubview(self.contentView)
        backgroundView.addSubview(toolbar)
        self.addSubview(backgroundView)
    }
    
    internal func dismissViews() {
        if isPopoverMode {
            purchasePopUpViewController?.dismiss(animated: true, completion: nil)
            purchasePopUpViewController = nil // Release, as to not create a retain cycle.
        } else {
            animateViews(direction: .out)
        }
    }
    
    internal func animateViews(direction: AnimationDirection) {
        var backgroundFrame = backgroundView.frame
        
        if direction == .in {
            // Start transparent
            //
            self.backgroundColor = UIColor.black.withAlphaComponent(0)
            
            // Start picker off the bottom of the screen
            //
            backgroundFrame.origin.y = self.appWindow.bounds.size.height
            backgroundView.frame = backgroundFrame
            
            // Add views
            //
            addAllSubviews()
            appWindow.addSubview(self)
            
            // Animate things on screen
            //
            UIView.animate(withDuration: Constant.animationSpeed, animations: {
                self.backgroundColor = UIColor.black.withAlphaComponent(Constant.backgroundAlpha)
                backgroundFrame.origin.y = self.appWindow.bounds.size.height - self.backgroundView.bounds.height
                self.backgroundView.frame = backgroundFrame
            })
        } else {
            // Animate things off screen
            //
            UIView.animate(withDuration: Constant.animationSpeed, animations: {
                self.backgroundColor = UIColor.black.withAlphaComponent(0)
                backgroundFrame.origin.y = self.appWindow.bounds.size.height
                self.backgroundView.frame = backgroundFrame
            }, completion: { _ in
                self.removeFromSuperview()
            })
        }
    }
    
    @objc internal func cancel() {
        self.cancelHandler()
        self.dismissViews()
    }
    
    private func setup() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PurchasePopUpPresentor.cancel))
        tapGestureRecognizer.delegate = self
        self.addGestureRecognizer(tapGestureRecognizer)
        
        let fixedSpace = PurchasePopUpBarButtonItem.fixedSpace(width: appWindow.bounds.size.width * Constant.barButtonFixedSpacePadding)
        setToolbarItems(items: [fixedSpace, PurchasePopUpBarButtonItem.title(title: self.title), PurchasePopUpBarButtonItem.flexibleSpace() ,PurchasePopUpBarButtonItem.cancel(purchasePopUpPresentor: self), fixedSpace])
        
        self.backgroundColor = UIColor.black.withAlphaComponent(Constant.backgroundAlpha)
        backgroundView.backgroundColor = UIColor.white
        

        sizeViews()
        
    }
    
    private func applyToolbarButtonItemsSettings(withAction: Selector? = nil, settings: (_ barButton: UIBarButtonItem) -> Void) {
        for item in toolbar.items ?? [] {
            if let action = withAction, action == item.action {
                settings(item)
            }
            
            if withAction == nil {
                settings(item)
            }
        }
    }
}


extension PurchasePopUpPresentor : UIPopoverPresentationControllerDelegate {
    
    public func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        self.cancelHandler()
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // This *forces* a popover to be displayed on the iPhone
        return .none
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // This *forces* a popover to be displayed on the iPhone X Plus
        return .none
    }
}

extension PurchasePopUpPresentor : UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let goodView = touch.view {
            return goodView == self
        }
        return false
    }
}
