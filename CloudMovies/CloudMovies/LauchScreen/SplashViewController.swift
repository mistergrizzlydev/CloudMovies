//
//  SplashViewController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
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
