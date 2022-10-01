//
//  DetailsScreenViewController.swift
//  PopCornCine
//
//  Created by Артем Билый on 28.09.2022.
//

import UIKit

class DetailsScreenViewController: UIViewController {
    
    private let scrollTestView = DetailView()
    
    //    fileprivate let rateStars = UIImageView() make it later
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollTestView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}
