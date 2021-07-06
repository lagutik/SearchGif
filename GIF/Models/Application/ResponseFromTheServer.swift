//
//  ResponseFromTheServer.swift
//  GIF
//
//  Created by admin on 26.05.2021.
//

import Foundation

struct ResponseFromTheServer: Decodable {
    var data: [DataFromTheServer]
}

struct DataFromTheServer: Decodable {
    var images: Images
}

struct Images: Decodable {
    var original: InformationAboutGif
}

struct InformationAboutGif: Decodable {
    var height: String
    var width: String
    var url: URL
}
