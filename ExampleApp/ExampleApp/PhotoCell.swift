//
//  ViewController.swift
//  ExampleApp
//
//  Created by Alvin He on 23/2/2023.
//

import AsyncDataLoader
import UIKit

class PhotoCell: UICollectionViewCell {

    static let reusedIdentifier = "ExampleApp.PhotoCell"

    private let imageView = UIImageView()

    private var task: Task<Void, Error>?

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.dismiss()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        self.contentView.addSubview(imageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }

    func dismiss() {
        self.task?.cancel()
        self.task = nil
        self.imageView.image = nil
    }

    func loadImage(_ url: String, asyncDataLoader: AsyncDataLoaderProtocol) {
        self.task = Task { [weak self] in
            do {
                let data = try await asyncDataLoader.data(from: url)
                self?.imageView.image = UIImage(data: data)
            } catch {
                print(error)
            }
        }
    }
}
