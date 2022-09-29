//
//  DetailsScreenViewController.swift
//  PopCornCine
//
//  Created by Артем Билый on 28.09.2022.
//

import UIKit

class DetailsScreenViewController: UIViewController {
    
    let textLabel = UILabel()
    override func viewDidLoad() {
        view.backgroundColor = .white
        textLabel.frame = CGRect(x: view.frame.midX, y: view.frame.midY, width: view.frame.width / 2, height: 100)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.center.x = view.center.x
        textLabel.center.y = view.center.y

        textLabel.text = "Hello, it s will be details screen :)"
        view.addSubview(textLabel)
    }
    
    override func viewDidLayoutSubviews() {
    }
}
