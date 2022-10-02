//
//  DetailsScreenViewController.swift
//  PopCornCine
//
//  Created by Артем Билый on 28.09.2022.
//

import UIKit

class DetailsScreenViewController: UIViewController {
    
    private let scrollTestView = DetailsScrollView()
    
    //    fileprivate let rateStars = UIImageView() make it later
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scrollTestView)
        navigationItem.largeTitleDisplayMode = .never
        title = scrollTestView.itemTitle.text
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}
