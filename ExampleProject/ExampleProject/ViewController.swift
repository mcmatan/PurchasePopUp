//
//  ViewController.swift
//  ExampleProject
//
//  Created by Matan Cohen on 2/27/18.
//  Copyright © 2018 Matan. All rights reserved.
//

import UIKit
import PurchasePopUp

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupImageBackground()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            let someView = self.getContentView()
            
            PurchasePopUpPresentor.show(contentView: someView, title: "Your amazing title", cancelHandler: {
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
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding * 2).isActive = true
        description.leadingAnchor.constraint(equalTo: title.leadingAnchor, constant: 0).isActive = true
        description.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 0).isActive = true
        
        title.text = "Set your content view\nAutoLayout/Frame based"
        description.text = "Make it shine."
        
        title.textColor = UIColor.init(red: 148/255, green: 107/255, blue: 43/255, alpha: 1)
        description.textColor = UIColor.init(red: 236/255, green: 103/255, blue: 103/255, alpha: 1)
        
        title.numberOfLines = 2
        title.font = UIFont.systemFont(ofSize: 30, weight: .light)
        description.font = UIFont.systemFont(ofSize: 50, weight: .light)
        
        return contentView
    }
    
    private func setupImageBackground() {
        let image = UIImage.init(named: "backgroundImage.jpeg")
        let imageView = UIImageView(image: image)
        self.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
