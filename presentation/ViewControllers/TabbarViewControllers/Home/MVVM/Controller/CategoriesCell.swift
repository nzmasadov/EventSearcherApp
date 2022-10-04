//
//  CategoriesCell.swift
//  presentation
//
//  Created by Nazim Asadov on 11.09.22.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    var vc: UIViewController?
    var router: Router?
    
    var categories = [
        Categories(name: .concert, image: Asset.concert.image),
        Categories(name: .sport, image: Asset.basketball1.image),
        Categories(name: .film, image: Asset.film.image),
        Categories(name: .music, image: Asset.music.image),
        Categories(name: .performance, image: Asset.icons8PublicSpeaking64.image),
        Categories(name: .upsell, image: Asset.upsell.image),
        Categories(name: .tourism, image: Asset.tourism.image),
        Categories(name: .arts, image: Asset.theatre.image),
        Categories(name: .nonticket, image: Asset.nonticket.image),
        Categories(name: .undefined, image: Asset.mixed.image)
    ]
    
    private lazy var headerView : EventsHeaderResuableView = {
        let view = EventsHeaderResuableView()
        contentView.addSubview(view)
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.bounces = true
        collection.alwaysBounceHorizontal = true
        collection.backgroundColor = .appBackGroundColor
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = .init(top: 0, left: 20, bottom: 0, right: 30)
        collection.delegate = self
        collection.dataSource = self
        self.contentView.addSubview(collection)
        return collection
    }()
      
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        headerView.viewLabel.isHidden = true
        collectionView.register(CategoriesChildCell.self, forCellWithReuseIdentifier: "\(CategoriesChildCell.self)")
  
        headerView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(35)
        }
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(110)
            make.bottom.right.left.equalToSuperview()
        }
    }
    
    func configureHeader(title: String) {
        headerView.titleLabel.text = title
    }
}

extension CategoriesCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return categories.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoriesChildCell.self)", for: indexPath) as! CategoriesChildCell
                     
            cell.setUIComponents(categories[indexPath.row])
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pagedVC = router?.pagedEventsViewController()
        pagedVC?.categoryType = self.categories[indexPath.row].name
        pagedVC?.hidesBottomBarWhenPushed = true
        self.vc?.navigationController?.pushViewController(pagedVC!, animated: true)
    }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 100, height: 80)
    }
}
