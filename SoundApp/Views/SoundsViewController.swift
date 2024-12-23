//
//  SoundsViewController.swift
//  ScreenTask
//
//  Created by Faisal Iqbal on 17/12/2024.
//
import UIKit

class SoundsViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var bottomCollectionView: UICollectionView!
    private let soundItems:  [SoundItem]  = [
        SoundItem(mainImage: UIImage(named: "frame")!,
                  smallImage1: UIImage(named: "rain")!,
                  smallImage2: UIImage(named: "ocean")!,
                  smallImage3: UIImage(named: "fire")!,
                  title: "Stress relief",
                  mainBackgroundColor: .fireColor,
                  smallBackgroundColor1: .rainColor,
                  smallBackgroundColor2: .wavesColor,
                  smallBackgroundColor3: .fireColor),
        SoundItem(mainImage: UIImage(named: "rainframe")!,
                  smallImage1: UIImage(named: "rain")!,
                  smallImage2: UIImage(named: "forest")!,
                  smallImage3: UIImage(named: "birds")!,
                  title: "Rainy day",
                  mainBackgroundColor: .fireColor,
                  smallBackgroundColor1: .rainColor,
                  smallBackgroundColor2: .forestColor,
                  smallBackgroundColor3: .birdsColor),
        SoundItem(mainImage: UIImage(named: "fire")!,
                  smallImage1: UIImage(named: "fire")!,
                  smallImage2: UIImage(named: "wind")!,
                  smallImage3: UIImage(named: "thunder")!,
                  title: "Cozy fire",
                  mainBackgroundColor: .fireColor,
                  smallBackgroundColor1: .fireColor,
                  smallBackgroundColor2: .windColor,
                  smallBackgroundColor3: .thunderColor),
        SoundItem(mainImage: UIImage(named: "lightframe")!,
                  smallImage1: UIImage(named: "guitar")!,
                  smallImage2: UIImage(named: "ocean")!,
                  smallImage3: UIImage(named: "piano")!,
                  title: "Intimate night",
                  mainBackgroundColor: .fireColor,
                  smallBackgroundColor1: .guitarColor,
                  smallBackgroundColor2: .wavesColor,
                  smallBackgroundColor3: .pianoColor)
    ]
    private let bottomItems: [BottomItem] = [
        BottomItem(image: UIImage(named: "piano")!, label: "Piano", backgroundColor: .pianoColor),
        BottomItem(image: UIImage(named: "rain")!, label: "Rain", backgroundColor: .rainColor),
        BottomItem(image: UIImage(named: "guitar")!, label: "Guitar", backgroundColor: .guitarColor),
        BottomItem(image: UIImage(named: "wind")!, label: "Wind", backgroundColor: .windColor),
        BottomItem(image: UIImage(named: "fire")!, label: "Fire", backgroundColor: .fireColor),
        BottomItem(image: UIImage(named: "ocean")!, label: "Waves", backgroundColor: .wavesColor),
        BottomItem(image: UIImage(named: "thunder")!, label: "Thunder", backgroundColor: .thunderColor),
        BottomItem(image: UIImage(named: "underWater")!, label: "Scuba", backgroundColor: .scubaColor),
        BottomItem(image: UIImage(named: "waterDrops")!, label: "Droplets", backgroundColor: .dropletsColor),
        BottomItem(image: UIImage(named: "coffee")!, label: "Coffee Shop", backgroundColor: .coffeeColor),
        BottomItem(image: UIImage(named: "forest")!, label: "Forest", backgroundColor: .forestColor),
        BottomItem(image: UIImage(named: "birds")!, label: "Birds", backgroundColor: .birdsColor)
    ]
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommended sounds"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let scrollView: UIScrollView  = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupBottomCollectionView()
        setupViews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        adjustCollectionViewHeight()
        adjustBottomCollectionViewHeight()
    }
    private func adjustCollectionViewHeight() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let rows = ceil(Double(soundItems.count) / 2.0)
            let height = rows * Double(layout.itemSize.height + layout.minimumLineSpacing) - layout.minimumLineSpacing
            collectionView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        }
    }
    private func adjustBottomCollectionViewHeight() {
        if let layout = bottomCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let rows = ceil(Double(bottomItems.count) / 3.0)
            let height = rows * Double(layout.itemSize.height + layout.minimumLineSpacing) - layout.minimumLineSpacing
            bottomCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        }
    }
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 162, height: 200)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SoundCollectionViewCell.self, forCellWithReuseIdentifier: SoundCollectionViewCell.identifier)
    }
    private func setupBottomCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 73, height: 73)
        layout.minimumLineSpacing = 37
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .vertical
        bottomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        bottomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomCollectionView.backgroundColor = .white
        bottomCollectionView.showsVerticalScrollIndicator = false
        bottomCollectionView.dataSource = self
        bottomCollectionView.delegate = self
        bottomCollectionView.register(BottomCollectionViewCell.self, forCellWithReuseIdentifier: BottomCollectionViewCell.identifier)
    }
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(bottomCollectionView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            collectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 28),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),

            descriptionLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 32),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),

            bottomCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            bottomCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            bottomCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            bottomCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
extension SoundsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return soundItems.count
        } else {
            return bottomItems.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SoundCollectionViewCell.identifier, for: indexPath) as? SoundCollectionViewCell
            let item = soundItems[indexPath.row]
            cell?.configure(with: item)
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomCollectionViewCell.identifier, for: indexPath) as? BottomCollectionViewCell
            let item = bottomItems[indexPath.row]
            cell?.configure(with: item)
            return cell!
        }
    }
}
