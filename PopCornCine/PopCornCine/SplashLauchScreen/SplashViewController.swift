//
//  SplashViewController.swift
//  PopCornCine
//
//  Created by Артем Билый on 28.09.2022.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    var logoIsHidden: Bool = false
    
    static let logoImageBig: UIImage = UIImage(named: "popcornbig")!

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImageView.isHidden = logoIsHidden
    }
}
