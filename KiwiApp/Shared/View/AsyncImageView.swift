//
//  AsyncImageView.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/8/21.
//

import UIKit

class AsyncImageView: UIImageView {
    private var loadingURL: URL?

    func load(url: URL) {
        guard url != loadingURL else {return}
        loadingURL = url
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
            self?.loadingURL = nil
        }
    }
}
