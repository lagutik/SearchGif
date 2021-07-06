//
//  GifManagerProtocol.swift
//  GIF
//
//  Created by admin on 06.07.2021.
//

import Foundation

protocol GifManagerProtocol {
    func requestGifs(with name: String, completion: @escaping ([InformationAboutGif]?, Error?) -> ())
}
