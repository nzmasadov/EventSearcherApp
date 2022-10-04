//
//  FavoritesViewController.swift
//  presentation
//
//  Created by Nazim Asadov on 10.09.22.
//

import UIKit
import Lottie
import domain

public class SearchViewController: BaseViewController<FirstViewModel>, UISearchBarDelegate {
    
    // MARK: Variables
    var isNotFound:Bool = false
    var allEvents: InitialEvents?
        
    // MARK: UI Components
    private lazy var searchBar: UISearchBar = {
       let search = UISearchBar()
        search.searchBarStyle = .default
        search.sizeToFit()
        let attributes = [NSAttributedString.Key.font : UIFont(font: FontFamily.Poppins.light, size: 14)]
        search.searchTextField.attributedPlaceholder = NSAttributedString(string: " Find amazing events", attributes: attributes as [NSAttributedString.Key : Any])
        search.isTranslucent = false
        search.delegate = self
        search.backgroundImage = UIImage()
        search.backgroundColor = .appBackGroundColor
        
        self.view.addSubview(search)
        return search
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.bounces = true
        collection.alwaysBounceVertical = true
        collection.backgroundColor = .appBackGroundColor
        collection.showsVerticalScrollIndicator = false
        collection.contentInset = .init(top: 10, left: 15, bottom: 0, right: 15)
        collection.delegate = self
        collection.dataSource = self
        collection.register(EventsChildCell.self, forCellWithReuseIdentifier: "\(EventsChildCell.self)")
        
        self.view.addSubview(collection)
        return collection
    }()
    
    // MARK: Pattern Delegates
    public override func viewDidLoad() {
        super.viewDidLoad()
//        extendedLayoutIncludesOpaqueBars = true
        navigationItem.title = "Search"

        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchHeader")
        
        setupUI()
    }
    
    private func setupUI() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        
    }
    
//    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        let second = searchText.filter({ !$0.isWhitespace})
//
//        print(second)
//        vm?.getSearchedEvents(with: searchText).then({ events in
//            self.allEvents = events
////            self.collectionView.reloadData()
//        })
//    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        AppLoader.instance.showLoaderView()
        let trimmedText = searchBar.searchTextField.text?.filter({ !$0.isWhitespace})
        vm?.getSearchedEvents(with: trimmedText ?? "").then({ [weak self] events in
            guard let self else {return}
            AppLoader.instance.hideLoaderView()
            self.allEvents = events
            self.collectionView.reloadData()
        })
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allEvents?.events.events.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(EventsChildCell.self)", for: indexPath) as! EventsChildCell
                
        if let events = self.allEvents?.events.events[indexPath.row] {
            cell.setUIComponentsForEvents(events)
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.event = allEvents?.events.events[indexPath.row]
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width / 2) - 20, height: 200)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let searchBarHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchHeader", for: indexPath)
        
        searchBarHeader.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(48)
        }
        updateHeight(height: 48, radius: 16)
        return searchBarHeader
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 80)
    }
}

private extension UIImage {
    static func imageWithColor(color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
}

extension SearchViewController {
    private func updateHeight(height: CGFloat, radius: CGFloat = 8.0) {
        let image: UIImage? = UIImage.imageWithColor(color: UIColor.lightGray.withAlphaComponent(0.2), size: CGSize(width: 1, height: height))
        searchBar.setSearchFieldBackgroundImage(image, for: .normal)
        for subview in self.searchBar.subviews {
            for subSubViews in subview.subviews {
                subSubViews.backgroundColor = .appBackGroundColor
                if #available(iOS 13.0, *) {
                    for child in subSubViews.subviews {
                        if let textField = child as? UISearchTextField {
                            textField.backgroundColor = .appBackGroundColor
                            textField.clipsToBounds = true
                            textField.layer.cornerRadius = radius
                        }
                    }
                }
            }
        }
    }
}
