//
//  Background.swift
//  CloudMovies
//
//  Created by Артем Билый on 21.10.2022.
//

import UIKit

final class BackgroundView: UICollectionReusableView {

    static let identifier = "background"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.1019608006, green: 0.1019608006, blue: 0.1019608006, alpha: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
