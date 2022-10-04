//
//  EventsCollectionViewCell.swift
//  presentation
//
//  Created by Nazim Asadov on 10.09.22.
//

import UIKit
import domain


class EventsCell: UICollectionViewCell {
    
    var vc: UIViewController?
    var eventsClassification: [ProfileData]?
    var initialEvents: InitialEvents?
    var allEvents: [EventResponse] = [] {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
    
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
                
        collectionView.register(EventsChildCell.self, forCellWithReuseIdentifier: "\(EventsChildCell.self)")
  
        headerView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(40)
        }
        collectionView.snp.makeConstraints { make in
//            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.height.equalTo(200)
            make.bottom.right.left.equalToSuperview()
        }
    }
    
    func configureHeader(title: String, type: EventsType.EventCategories, router: Router) {
        headerView.titleLabel.text = title
        headerView.viewAllTapped(with: type, navigation: (vc?.navigationController)!, router: router)
    }
}

extension EventsCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(EventsChildCell.self)", for: indexPath) as! EventsChildCell
        cell.setUIComponentsForEvents(self.allEvents[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.event = allEvents[indexPath.row]
        vc.modalPresentationStyle = .overFullScreen
        self.vc?.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 280, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
