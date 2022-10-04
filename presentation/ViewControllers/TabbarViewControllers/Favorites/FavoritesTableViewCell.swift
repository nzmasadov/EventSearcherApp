//
//  ExploreTableViewCell.swift
//  presentation
//
//  Created by Nazim Asadov on 12.09.22.
//

import UIKit
import Kingfisher
import domain

class FavoritesTableViewCell: UITableViewCell {
    
    private lazy var imgView : UIImageView = {
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
        
        imgView.addSubview(label)
        return label
    }()
    
    private lazy var nameLbl: UILabel = {
        let label = UILabel()

        label.configureLabel(textColor: .label, textAlignment: .left)
        label.numberOfLines = 1
        label.font = UIFont(font: FontFamily.Poppins.bold, size: 16)
        addSubview(label)
        return label
    }()
    
    private lazy var placeLbl: UILabel = {
        let label = UILabel()

        label.configureLabel(textColor: .label, textAlignment: .left)
        label.numberOfLines = 1
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
    
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = 16
        backgroundColor = .appBackGroundColor
        
        imgView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(150)
        }
        
        priceLbl.snp.makeConstraints { make in
            make.right.equalTo(imgView.snp.right).offset(-10)
            make.bottom.equalTo(imgView.snp.bottom).offset(-15)
            make.width.equalTo(85)
            make.height.equalTo(28)
        }
        
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(5)
            make.left.equalTo(imgView.snp.left).offset(10)
            make.right.equalTo(imgView.snp.right).offset(-5)
        }
        
        dateLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(5)
            make.left.equalTo(imgView.snp.left).offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
        
        placeLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(5)
            make.left.equalTo(dateLbl.snp.right).offset(8)
            make.right.equalTo(imgView.snp.right).offset(-5)
        }
    }
    
    func setUIComponentsForEvents(_ event: EventResponse) {
        if event.priceRanges.first?.min == nil {
            priceLbl.isHidden = true
        }else {
            priceLbl.isHidden = false
            priceLbl.text = "from $\(event.priceRanges.first?.min ?? 0.0)"
        }
        
        imgView.kf.setImage(with: URL(string: getHighQuality(images: event.images)))
        nameLbl.text = event.name
        placeLbl.text = event._embedded.venues.first?.name
        if event.dates.start.localTime != "" {
            dateLbl.text = event.dates.start.localDate + " • " + event.dates.start.localTime
        }else {
            dateLbl.text = event.dates.start.localDate + "  " + event.dates.start.localTime
        }
    }
}
