//
//  GifManager.swift
//  GIF
//
//  Created by admin on 06.07.2021.
//

import Moya

class GifManager: GifManagerProtocol {
    
    // MARK: - Properties
    private let provider: MoyaProvider<GifApiService>
    
    // MARK: - Initialization
    init(provider: MoyaProvider<GifApiService>) {
        self.provider = provider
    }
    
    func requestGifs(with name: String, completion: @escaping ([InformationAboutGif]?, Error?) -> ()) {
        provider.request(.search(name: name))
        { (result) in
            switch result {
            case .failure(let error):
                completion(nil, error)
            case .success(let response):
                do {
                    let gifs = try response.map(ResponseFromTheServer.self)
                    var arrayInformationAboutGif = [InformationAboutGif]()
                    
                    for element in gifs.data {
                        arrayInformationAboutGif.append(element.images.original)
                    }
                    completion(arrayInformationAboutGif, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
}
