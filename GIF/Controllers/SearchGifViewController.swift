//
//  SearchGifViewController.swift
//  GIF
//
//  Created by admin on 25.05.2021.
//

import UIKit
import Moya

class SearchGifViewController: UIViewController {
    
    // MARK: - Constants
    private lazy var cellHeight: CGFloat = 150
    private lazy var cellWidth: CGFloat = collectionView.frame.width / 2 - 10
    
    // MARK: IBOutlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    // MARK: Properties
    fileprivate let gifManager: GifManagerProtocol = GifManager(provider: MoyaProvider<GifApiService>(plugins: [NetworkLoggerPlugin()]))
    fileprivate var arrayGif = [InformationAboutGif]()
    
    private let timerManager: TimerManager? = TimerManager(timeDelay: Application.Timer.defaultTime)
    
    // MARK: Lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    // MARK: - Configurations
    private func configure() {
        
        timerManager?.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewCellWithGif", bundle: nil),
                                forCellWithReuseIdentifier: CollectionViewCellWithGif.identifier)
        
        textField.returnKeyType = .done
        collectionView.keyboardDismissMode = .onDrag
    }
    
    // MARK: IBAction
    @IBAction func textFiedAction(_ sender: UITextField) {
        arrayGif.removeAll()
        collectionView.reloadData()
        
        if textField.text?.isEmpty == true {
            loader.stopAnimating()
        } else {
            loader.startAnimating()
            timerManager?.startTimer()
        }
    }
}

// MARK: CollectionViewDataSource
extension SearchGifViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayGif.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellWithGif.identifier, for: indexPath) as! CollectionViewCellWithGif
        cell.runGif(with: arrayGif[indexPath.row].url)
        return cell
    }
}

// MARK: CollectionViewFlowLayout
extension SearchGifViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth , height: cellHeight)
    }
}

// MARK: DelayToGetTextDelegate
extension SearchGifViewController: TimerManagerDelegate {
    func timerСompleted() {
        guard let text = textField.text,
              text.isEmpty == false else {
            return
        }
        
        gifManager.requestGifs(with: text) { [weak self] (array, error) in
            self?.loader.stopAnimating()
            
            if let gifs = array {
                self?.arrayGif = gifs
                self?.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                self?.collectionView.reloadData()
            } else if let error = error {
                self?.displayError(message: error.localizedDescription)
            }    
        }
    }
    
    private func displayError(message: String) {
        let alert = UIAlertController(title: "Oops, an error occurred", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
