//
//  EventsChildCell.swift
//  presentation
//
//  Created by Nazim Asadov on 10.09.22.
//

import UIKit
import domain

class EventsChildCell: UICollectionViewCell {

    lazy var imageView : UIImageView = {
        let imgView = UIImageView()

        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 16
        imgView.contentMode = .scaleAspectFill
        addSubview(imgView)
        return imgView
    }()
    
    private lazy var priceLbl: UILabel = {
        let label = UILabel()
        
        label.configureLabel(textColor: UIColor.white, textAlignment: .center)
        label.font = UIFont(font: FontFamily.Poppins.semiBold, size: 13)
        label.backgroundColor = .systemOrange
        label.clipsToBounds = true
        label.layer.cornerRadius = 13
        
        imageView.addSubview(label)
        return label
    }()
    
    private lazy var nameLbl: UILabel = {
        let label = UILabel()

        label.configureLabel(textColor: .label, textAlignment: .left)
        label.numberOfLines = 1
        label.font = UIFont(font: FontFamily.Poppins.bold, size: 14)
        addSubview(label)
        return label
    }()
    
    private lazy var placeLbl: UILabel = {
        let label = UILabel()

        label.configureLabel(textColor: .label, textAlignment: .left)
        label.numberOfLines = 0
        label.font = UIFont(font: FontFamily.Poppins.medium, size: 13)
        addSubview(label)
        return label
    }()
    
    private lazy var  dateLbl: UILabel = {
        let label = UILabel()

        label.configureLabel(textColor: .label, textAlignment: .left)
        label.numberOfLines = 0
        label.font = UIFont(font: FontFamily.Poppins.medium, size: 13)
        addSubview(label)
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    @objc func addFavorite() {
        
    }
    
    private func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = 16
        
        imageView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(150)
        }
        
        priceLbl.snp.makeConstraints { make in
            make.right.equalTo(imageView.snp.right).offset(-10)
            make.bottom.equalTo(imageView.snp.bottom).offset(-15)
            make.width.equalTo(85)
            make.height.equalTo(28)
        }
        
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.left.equalTo(imageView.snp.left).offset(5)
            make.right.equalTo(imageView.snp.right).offset(-2)
        }
        
        dateLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(5)
            make.left.equalTo(imageView.snp.left).offset(10)
        }
        
        placeLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(5)
            make.left.equalTo(dateLbl.snp.right).offset(8)
        }
    }
    
    func setUIComponentsForEvents(_ event: EventResponse) {
        
        var currency = ""
        if event.priceRanges.first?.currency == "EUR" {
            currency = "€"
        }else {
            currency = "$"
        }
        
        if event.priceRanges.first?.min == nil {
            priceLbl.isHidden = true
        }else {
            priceLbl.isHidden = false
            priceLbl.text = "from \(currency)\(event.priceRanges.first?.min ?? 0.0)"
        }
        
        imageView.kf.setImage(with: URL(string: getHighQuality4x3(images: event.images)))
        nameLbl.text = event.name
        priceLbl.text = "from \(currency)\(event.priceRanges.first?.min ?? 0.0000)"
        placeLbl.text = event._embedded.venues.first?.name
        dateLbl.text = event.dates.start.localDate.dateString(from: "yyyy-MM-dd", to: "dd.MM.yyyy") + "  " + event.dates.start.localTime.dateString(from: "HH:mm:ss", to: "HH:mm")
    }
    
    func getHighQuality4x3(images: [EventResponse.Image]) -> String {
        let filtered = images.filter { image in
            image.ratio == "4_3"
        }
        
        for i in filtered {
            return i.url
        }
        return images.first?.url ?? ""
    }
}
