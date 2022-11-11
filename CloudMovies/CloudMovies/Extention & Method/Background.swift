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
        backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
