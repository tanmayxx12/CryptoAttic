//
//  CoinImageService.swift
//  CryptoAttic
//
//  Created by Tanmay . on 22/11/24.
//

import Combine
import Foundation
import SwiftUI

class CoinImageService {
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManger = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin 
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManger.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retrieved Image from FileManager")
        } else {
            downloadCoinImage()
            print("Downloading images now...")
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage  in
                guard let image = UIImage(data: data) else {
                    print("Failed to convert data to UIImage")
                    throw URLError(.badServerResponse)
                }
                return image
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] downloadedImage in
                guard let self = self else { return }
                self.image = downloadedImage
                // We can cancel the subscription after we are done getting the data from the internet once (we are not getting any data over time with the URL used above)
                self.imageSubscription?.cancel()
                self.fileManger.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
    
    
}
