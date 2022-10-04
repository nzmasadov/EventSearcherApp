//
//  PagedEventsViewController.swift
//  presentation
//
//  Created by Nazim Asadov on 20.09.22.
//

import Foundation
import UIKit
import domain

public class PagedEventsViewController: BaseViewController<PagedEventsViewModel> {
    
//    public init (eventType: EventsType.EventCategories) {
//        self.eventType = eventType
//        super.init()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    var eventType: EventsType.EventCategories?
    var categoryType: Categories.CategoryType?
    var mockName = ""
    
    var initialEvents: InitialEvents?
    private var events: [EventResponse] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var page = 0
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        
        //        table.allowsSelectionDuringEditing = false
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "\(FavoritesTableViewCell.self)")
        table.contentInset = UIEdgeInsets(top: 20, left: 00, bottom: 0, right: 0)
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .appBackGroundColor
        
        self.view.addSubview(table)
        return table
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
                
        if eventType != nil {
            navigationItem.title = eventType?.rawValue
            switch eventType {
            case .suggested:
                mockName = "upsell"
            case .tourism:
                mockName = "venue%20based"
            case .sport:
                mockName = "group"
            case .concert:
                mockName = "concert"
            case .performance:
                mockName = "individual"
            default:
                break
            }
        }else {
            navigationItem.title = categoryType?.rawValue
            switch categoryType {
            case .arts:
                mockName = "individual"
            case .sport:
                mockName = "sport"
            case .concert:
                mockName = "concert"
            case .performance:
                mockName = "individual"
            case .nonticket:
                mockName = "nonticket"
            case .upsell:
                mockName = "upsell"
            case .tourism:
                mockName = "venue%20based"
            case .music:
                mockName = "music"
            case .undefined:
                mockName = "undefined"
            case .film:
                mockName = "film"
            default:
                break
            }
        }
        AppLoader.instance.showLoaderView()
        vm?.getPagedEvents(with: mockName , page: 0).then({ [weak self] initialEvents in
            guard self != nil else {return}
            AppLoader.instance.hideLoaderView()
            self?.events = initialEvents.events.events
            self?.initialEvents = initialEvents
        })
    }
    
    private func setupUI() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
    
extension PagedEventsViewController: UITableViewDelegate, UITableViewDataSource {
        
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return events.count
        }
        
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoritesTableViewCell.self)", for: indexPath) as! FavoritesTableViewCell
            
            cell.setUIComponentsForEvents(self.events[indexPath.row])
            return cell
        }
        
        public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let vc = DetailVC()
            vc.event = events[indexPath.row]
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if initialEvents?.pagedLinks.lastPage != initialEvents?.pagedLinks.nextPage && initialEvents?.pagedLinks.nextPage != nil && indexPath.row == (events.count - 1) {
                self.page += 1
            AppLoader.instance.showLoaderView()
            vm?.getPagedEvents(with: mockName, page: page).then({ [weak self] initialEvents in
                guard self != nil else {return}
                AppLoader.instance.hideLoaderView()
                self?.initialEvents = initialEvents
                self?.events.append(contentsOf: initialEvents.events.events)
                tableView.reloadData()
            })
        }
    }
}
