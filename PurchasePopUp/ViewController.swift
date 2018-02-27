//
//  ViewController.swift
//  PurchasePopUp
//
//  Created by Matan Cohen on 2/27/18.
//  Copyright © 2018 Matan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            let someView = self.getContentView()
            
            PurchasePopUpPresentor.show(contentView: someView, title: "Some title", cancelHandler: {
                //
            })
        }
    }
    
    private func getContentView() -> UIView {
        let padding = CGFloat(20)
        let contentView = UIView()
        let title = UILabel()
        let description = UILabel()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        description.translatesAutoresizingMaskIntoConstraints = false
        
    
        contentView.addSubview(title)
        contentView.addSubview(description)
        
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        description.leadingAnchor.constraint(equalTo: title.leadingAnchor, constant: padding).isActive = true
        description.topAnchor.constraint(equalTo: title.bottomAnchor, constant: padding).isActive = true
        
        title.text = "This is some title..."
        description.text = "This is some description..."
        
        return contentView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

