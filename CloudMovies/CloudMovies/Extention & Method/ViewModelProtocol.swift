//
//  ViewModelProtocol.swift
//  CloudMovies
//
//  Created by Artem Bilyi on 29.11.2022.
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func updateView()
    func reload()
}

extension ViewModelProtocol {
    func showLoading() { }
    func hideLoading() { }
    func updateView() { }
    func reload() { }
}
