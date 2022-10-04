//
//  SearchViewController.swift
//  presentation
//
//  Created by Nazim Asadov on 10.09.22.
//

import UIKit
import SnapKit
import domain
import Firebase
import FirebaseAuth

public class FavoritesViewController: BaseViewController<FirstViewModel>, DetailDismissDelegate {
    
    private var ids: [String] = []
    private var events: [EventResponse] = [] {
        didSet {
            tableView.reloadData()
        }
    }
            
    private lazy var blankAnimation = BlankAnimationView()
    private lazy var tableView: UITableView = {
       let table = UITableView()
        
        table.allowsSelectionDuringEditing = false
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "\(FavoritesTableViewCell.self)")
        table.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .appBackGroundColor
        
        self.view.addSubview(table)
        return table
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorites"
        view.backgroundColor = .appBackGroundColor
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateEventWithIds()
    }
    
    private func updateEventWithIds() {
        events.removeAll()
        readIds { eventIds in
            self.ids = eventIds
            eventIds.forEach { id in
                self.vm?.getEvent(with: id).then({ [weak self] event in
                    guard (self != nil) else {return}
                    self?.events.append(event)
                })
            }
            self.setupUI(ids: self.ids)
        }
    }
    
    private func setupUI(ids: [String]) {
        
        if ids.count > 0 {
            blankAnimation.removeFromSuperview()
            self.view.addSubview(tableView)
            tableView.snp.makeConstraints { make in
                make.top.equalTo(self.view.snp.top)
                make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
                make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            }
        }else {
            tableView.removeFromSuperview()
            self.view.addSubview(blankAnimation)
            blankAnimation.animationView.play()
            setupBlankAnimation()
        }
    }
    
    private func setupBlankAnimation() {
        blankAnimation.snp.makeConstraints { make in
            make.centerY.equalTo(self.view.safeAreaLayoutGuide.snp.centerY).offset(-40)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.view.frame.size.width)
            make.height.equalTo(400)
        }
    }
    
    func backClicked() {
        updateEventWithIds()
    }
    
    func readIds(_ completion: @escaping(_ eventIds:[String])->Void){
        let db = Firestore.firestore()
        let currentUser = FirebaseAuth.Auth.auth().currentUser
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

extension FavoritesViewController:  UITableViewDelegate, UITableViewDataSource {
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
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}
