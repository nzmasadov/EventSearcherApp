//
//  HomeViewController.swift
//  presentation
//
//  Created by Nazim Asadov on 10.09.22.
//

import Foundation
import UIKit
import SnapKit
import domain
import FirebaseFirestore
import FirebaseAuth
import RxSwift

protocol TabBarItemsSwicthDelegate: AnyObject {
    func switchItems(index: Int)
}

public class HomeViewController: BaseViewController<FirstViewModel> {
    
    private var eventSubscription: Disposable? = nil
    private var disposeBag = DisposeBag()
    
    let database = Firestore.firestore()
    weak var delegate: TabBarItemsSwicthDelegate?
    
    //MARK: Variables
    var events = [
        EventsType(type: .categories),
        EventsType(type: .suggested),
        EventsType(type: .concert),
        EventsType(type: .sport),
        EventsType(type: .performance),
        EventsType(type: .tourism)
    ]
        
    var initialEvents: [InitialEvents]? = [] {
        didSet {
            if initialEvents?.count == 5 {
                collectionView.delegate = self
                collectionView.dataSource = self
            }
        }
    }
    
    var timer: Timer?
    var runCount = 0
        
    //MARK: - UIComponents
    
    private lazy var gradientImageView : UIImageView = {
        let imgView = UIImageView()
        
        imgView.contentMode = .scaleAspectFill
        imgView.image = Asset.gradientBackground.image
        self.view.addSubview(imgView)
        return imgView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        //   flowLayout.minimumInteritemSpacing = 12
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.alwaysBounceVertical = true
        collection.backgroundColor = .appBackGroundColor
        collection.showsVerticalScrollIndicator = false
        collection.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        self.view.addSubview(collection)
        return collection
    }()
    
    
    //MARK: - Pattern Delegates
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vm?.observeEvents().subscribe({ event in
            guard let data = event.element else {return}
            
            print("nzm observe valu", data.pagedLinks.lastPage )
        })
        
        eventSubscription?.disposed(by: disposeBag)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        eventSubscription?.dispose()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        vm?.syncEvents()
        saveUserName()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        AppLoader.instance.showLoaderView()
        self.vm?.getClassificationEvents(with: "upsell").then({ suggestedEvents in
            self.initialEvents?.append(suggestedEvents)
        }).then({
            self.vm?.getClassificationEvents(with: "concert").then({ concertEvents in
                self.initialEvents?.append(concertEvents)
            }).then({
                self.vm?.getClassificationEvents(with: "group").then({ sportEvents in
                    self.initialEvents?.append(sportEvents)
                }).then({
                    self.vm?.getClassificationEvents(with: "individual").then({ performance in
                        self.initialEvents?.append(performance)
                    }).then({
                        self.vm?.getClassificationEvents(with: "venue%20based").then({ tourism in
                            AppLoader.instance.hideLoaderView()
                            self.initialEvents?.append(tourism)
                        })})})})})
        
        if #available(iOS 15.0, *) {
            setupNavigationItems()
        }
        setupUI()
    }
    
    @available(iOS 15.0, *)
    private func setupNavigationItems() {
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationItem.rightBarButtonItem =
        UIBarButtonItem(image: Asset.icBookmark.image.preparingThumbnail(of: CGSize(width: 32, height: 32)), style: .plain, target: self, action: #selector(moveFavorites))
        
        self.navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: Asset.eventLogo.image.preparingThumbnail(of: CGSize(width: 40, height: 37)), style: .plain, target: self, action: #selector(scrollToTop)),
            UIBarButtonItem(title: "Event Searcher", style: .done, target: self, action: #selector(scrollToTop))
        ]
        navigationItem.leftBarButtonItems?[1].setTitleTextAttributes([NSAttributedString.Key.font : UIFont(font: FontFamily.Poppins.semiBold, size: 22)!, NSAttributedString.Key.foregroundColor : UIColor.label], for: .normal)
    }
    
    private func setupUI() {
        collectionView.register(EventsCell.self, forCellWithReuseIdentifier: "\(EventsCell.self )")
        
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: "\(CategoriesCell.self )")
        
        collectionView.register(WelcomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(WelcomeHeaderView.self)")
        
        gradientImageView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(110)
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges).inset(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        }
    }
    
    func saveUserName() {
             let currentUser = FirebaseAuth.Auth.auth().currentUser
             let docRefName = database.document("profile/\(currentUser?.email ?? "")name")
             let docRefSurname = database.document("profile/\(currentUser?.email ?? "")surname")

             docRefName.getDocument { [weak self] snapshot, error in

                 guard let _ = self else {return}
                 guard let data = snapshot?.data(), error == nil else {
                     return
                 }
                 guard let name = data["\(currentUser?.email ?? "")"] as? String else {return}

                 UserDefaults.standard.set(name , forKey: "User_Name")
             }

             docRefSurname.getDocument { [weak self] snapshot,  error in
                 guard let _ = self else {return}
                 guard let data = snapshot?.data(), error == nil else {
                     return
                 }

                 guard let name = data["\(currentUser?.email ?? "")"] as? String else {return}
                 UserDefaults.standard.set(name , forKey: "User_Surname")
             }
         }
    
    @objc func fireTimer() {
        runCount += 1

        if runCount == 30 {
            timer?.invalidate()
        }
    }
    
    @objc func moveFavorites() {
        delegate?.switchItems(index: 2)
    }
    @objc func scrollToTop() {
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let headerTitle = events[indexPath.row].type.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(EventsCell.self)", for: indexPath) as! EventsCell
        cell.vc = self
        
        switch events[indexPath.row].type {
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoriesCell.self)", for: indexPath) as! CategoriesCell
            cell.vc = self
            cell.configureHeader(title: headerTitle)
            cell.router = self.router as? Router
            return cell
        case .suggested:
            cell.configureHeader(title: headerTitle, type: .suggested, router: router as! Router)
            cell.allEvents = initialEvents?[0].events.events ?? []
        case .concert:
            cell.configureHeader(title: headerTitle, type: .concert, router: router as! Router)
            cell.allEvents = initialEvents?[1].events.events ?? []
        case .sport:
            cell.configureHeader(title: headerTitle, type: .sport, router: router as! Router)
            cell.allEvents = initialEvents?[2].events.events ?? []
        case .performance:
            cell.configureHeader(title: headerTitle, type: .performance, router: router as! Router)
            cell.allEvents = initialEvents?[3].events.events ?? []
        case .tourism:
            cell.configureHeader(title: headerTitle, type: .tourism, router: router as! Router)
            cell.allEvents = initialEvents?[4].events.events ?? []
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch events[indexPath.row].type {
        case .categories:
            return CGSize(width: self.view.frame.width, height: 140)
        default:
            return CGSize(width: self.view.frame.width, height: 250)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let welcomeHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(WelcomeHeaderView.self)", for: indexPath) as! WelcomeHeaderView
        return welcomeHeader
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
}
