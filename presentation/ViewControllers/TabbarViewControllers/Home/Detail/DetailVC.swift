//
//  EventDetailViewController.swift
//  presentation
//
//  Created by Nazim Asadov on 11.09.22.
//

import Foundation
import UIKit
import domain
import Kingfisher
import Firebase
import FirebaseFirestore
import FirebaseAuth

protocol DetailDismissDelegate: AnyObject {
    func backClicked()
}

class DetailVC: UIViewController {
    
    let db = Firestore.firestore()
    let currentUser = FirebaseAuth.Auth.auth().currentUser
    var eventIds: [String] = []
    
    var event: EventResponse?
    var eventDetailData: [DetailModel] = []
    
    weak var delegate: DetailDismissDelegate?
    
    private lazy var eventImgView: UIImageView = {
       let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        view.backgroundColor = .black
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var detailHeaderView: DetailHeaderView = {
       let view = DetailHeaderView()
        
        self.eventImgView.addSubview(view)
        return view
    }()
        
    private lazy var containerView: UIView = {
       let view = UIView()
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = .appBackGroundColor
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        self.containerView.addSubview(view)
        return view
    }()
    
    private lazy var scrollContentView: UIView = {
        let view = UIView()
        
        self.scrollView.addSubview(view)
        return view
    }()
    
    private lazy var detailTopView: DetailTopView = {
       let view = DetailTopView()
        
        self.scrollContentView.addSubview(view)
        return view
    }()
    
    private lazy var descriptionLbl: UILabel = {
        let label = UILabel()
        
        label.configureLabel(textColor: UIColor.gray, textAlignment: NSTextAlignment.left)
        label.font = UIFont(font: FontFamily.Poppins.light, size: 12)
        label.numberOfLines = 0

        scrollContentView.addSubview(label)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.isUserInteractionEnabled = false
        collection.bounces = false
        collection.alwaysBounceVertical = false
        collection.allowsSelection = false
        collection.backgroundColor = .appBackGroundColor
        collection.showsHorizontalScrollIndicator = false
//        collection.contentInset = .init(top: 15, left: 0, bottom: 15, right: 0)
        collection.delegate = self
        collection.dataSource = self
        collection.register(DetailCell.self, forCellWithReuseIdentifier: "\(DetailCell.self)")

        self.scrollContentView.addSubview(collection)
        return collection
    }()
    
    private lazy var seatmapImgView: UIImageView = {
       let view = UIImageView()
        
        view.contentMode = .scaleAspectFit
        self.scrollContentView.addSubview(view)
        return view
    }()
    
    private lazy var buyBtn: UIButton = {
        let button = UIButton()
        
        button.setTitle("Buy ticket", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(font: FontFamily.Poppins.semiBold, size: 17)
        button.backgroundColor = .systemOrange
        button.clipsToBounds = true
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(buyTapped), for: .touchUpInside)
        
        self.scrollContentView.addSubview(button)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let event = event else { return }
        
        setupUI()
        btnFunctions()
                
        eventImgView.kf.setImage(with: URL(string: getHighQuality(images: event.images)))
        detailTopView.eventNameLbl.text = event.name
        detailTopView.eventTypeLbl.text = event.classifications.first?.segment.name.lowercased()
        
        if event.info != "" {
            descriptionLbl.text = event.info
        }else if event._embedded.venues.first?.generalInfo.generalRule != "" {
            descriptionLbl.text = event._embedded.venues.first?.generalInfo.generalRule
        }else {
            descriptionLbl.text = event.name
        }
        
        let address = event._embedded.venues.first
        let fullAddress = (address?.address.line1 ?? "") + " " + (address?.state.name ?? "") + " " + (address?.city.name ?? "")
        var subtitle = ""
        var currency = ""
        if event.priceRanges.first?.currency == "EUR" {
            currency = "€"
        }else {
            currency = "$"
        }
        
        if event.priceRanges.first?.max != event.priceRanges.first?.min {
            subtitle = "from \(currency)\(event.priceRanges.first?.min ?? 25.0)  to \(currency)\(event.priceRanges.first?.max ?? 2000.0)"
        }else if event.priceRanges.first?.max == nil && event.priceRanges.first?.min == nil {
            subtitle = "Visit our website for price"
        }
        else {
            subtitle = "\(currency)\(event.priceRanges.first?.min ?? 25.0)"
        }
        
        var limitation = ""
        if event.ticketLimit.info == "" {
            limitation = "There is no restriction"
        }else {
            limitation = event.ticketLimit.info
        }
        
        eventDetailData = [
            DetailModel(title: "Location", subtitle: fullAddress, image: Asset.locationFilled2.image, backgroundColor: UIColor.systemPurple),
            DetailModel(title: "Date", subtitle: "\((event.dates.start.localDate.dateString(from: "yyyy-MM-dd", to: "dd.MM.yyyy") ) + "  " + (event.dates.start.localTime.dateString(from: "HH:mm:ss", to: "HH:mm")))", image: Asset.clockCalendar.image, backgroundColor: UIColor.systemBlue),
            DetailModel(title: "Price", subtitle: subtitle, image: Asset.price.image, backgroundColor: #colorLiteral(red: 0.9893080592, green: 0.5366089344, blue: 0.212097615, alpha: 1)),
            DetailModel(title: "Limitation", subtitle: limitation, image: Asset.accessUniversal.image, backgroundColor: UIColor.systemRed)
        ]
        
        seatmapImgView.kf.setImage(with: URL(string: event.seatmap.staticUrl))
    }
    
    private func btnFunctions() {
        detailHeaderView.backBtn.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        detailHeaderView.backView.addTapGesture {
            self.backTapped()
        }
        detailHeaderView.shareView.addTapGesture {
            self.shareTapped()
        }
        detailHeaderView.shareBtn.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        detailHeaderView.saveBtn.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        detailHeaderView.saveView.addTapGesture {
            self.saveTapped()
        }
    }
    
    @objc func saveTapped() {
        
        self.eventIds = []
        guard let event else {return}
        readIds { eventIds in
            self.eventIds = []
            eventIds.forEach { id in
                self.eventIds.append(id)
            }
            if self.eventIds.contains(event.id) {
                self.delete(id: event.id)
                self.detailHeaderView.saveBtn.setImage(Asset.icWhiteStar.image, for: .normal)
            }else {
                self.save(key: self.currentUser?.email?.lowercased() ?? "", savedId: event.id)
                self.detailHeaderView.saveBtn.setImage(Asset.icWhiteStar.image.withRenderingMode(.alwaysTemplate), for: .normal)
                self.detailHeaderView.saveBtn.tintColor = .systemYellow
            }
        }
    }
    
    @objc func backTapped() {
        delegate?.backClicked()
        self.dismiss(animated: true)
    }
    
    private func setupUI() {
        guard let event = event else { return }
        
        eventImgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(270)
        }
        
        detailHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        containerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(eventImgView.snp.bottom).offset(-15)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView.contentLayoutGuide.snp.top).offset(20)
            make.left.equalTo(self.scrollView.contentLayoutGuide.snp.left)
            make.right.equalTo(self.scrollView.contentLayoutGuide.snp.right)
            make.centerX.equalTo(self.scrollView.snp.centerX)
            make.bottom.equalTo(self.scrollView.contentLayoutGuide.snp.bottom)
//            make.height.greaterThanOrEqualTo(750)
        }
        
        detailTopView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(detailTopView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(descriptionLbl.snp.bottom).offset(20)
            make.height.equalTo(350)
        }
        
        seatmapImgView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            if event.seatmap.staticUrl != "" {
                make.height.equalTo(240)
            }else {
                make.height.equalTo(0)
            }
        }
        
        buyBtn.snp.makeConstraints { make in
            make.top.equalTo(seatmapImgView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(56)
            make.bottom.lessThanOrEqualTo(scrollContentView.snp.bottom).offset(-15)
        }
        
        readIds { eventIds in
            print("Nazim -> \(eventIds)")
            if eventIds.contains(event.id) {
                self.detailHeaderView.saveBtn.setImage(Asset.icWhiteStar.image.withRenderingMode(.alwaysTemplate), for: .normal)
                self.detailHeaderView.saveBtn.tintColor = .systemYellow
            }
        }
    }
 
    @objc func shareTapped() {
        let urlShare = [event?.url]
        let activityViewController = UIActivityViewController(activityItems: urlShare as [Any] , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
        
    @objc func buyTapped() {
//        if let url = URL(string: event?.url ?? "") {
//                UIApplication.shared.open(url)
//        }
        
        let vc = WebViewVC()
        vc.ticketUrl = event?.url ?? ""
        self.present(vc, animated: true)
    }
    
    func save(key: String, savedId: String) {
        let ref = db.document("\(key)/\(event?.id ?? "")")
        ref.setData([currentUser?.uid ?? "": savedId])
    }
    
    func delete(id: String) {
        db.collection(currentUser?.email?.lowercased() ?? "").document(event?.id ?? "").delete()
    }
    
    func readIds(_ completion: @escaping(_ eventIds:[String])->Void){
        db.collection(currentUser?.email?.lowercased() ?? "").getDocuments { (querySnapshot, err) in
            if let err = err {
                self.showAlert(with: err.localizedDescription)
            } else {
                var temporaryIds = [String]()
                if let documents = querySnapshot?.documents{
                    documents.forEach { eventIds in
                        temporaryIds.append(eventIds.data().values.first as! String)
                    }
                }
                completion(temporaryIds)
            }
        }
    }
}

extension DetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DetailCell.self)", for: indexPath) as! DetailCell
        cell.setUIComponents(eventDetailData[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: (self.collectionView.frame.width), height: 78)
    }
}


