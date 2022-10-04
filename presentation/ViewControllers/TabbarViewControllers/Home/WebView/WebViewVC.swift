//
//  WebViewVC.swift
//  presentation
//
//  Created by Nazim Asadov on 27.09.22.
//

import UIKit
import WebKit
import SnapKit

public class WebViewVC: BaseViewController<WebViewModel> {
    
    var ticketUrl = ""
    
    private lazy var webView: WKWebView = {
       let view = WKWebView()
        
        view.scrollView.bounces = false
        view.scrollView.bouncesZoom = false
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var backButton: UIButton = {
       let btn = UIButton()
        
        btn.tintColor = .label
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        btn.setImage(Asset.backArrow.image.withTintColor(.label, renderingMode: .alwaysTemplate), for: .normal)
        
        view.addSubview(btn)
        return btn
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        let javascript = "var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);"
        let us = WKUserScript(source: javascript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        webView.configuration.userContentController.addUserScript(us)
        
        guard let url = URL(string: ticketUrl) else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview().offset(12)
        }
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges).inset(UIEdgeInsets(top: 46, left: 0, bottom: 0, right: 0))
        }
    }
    @objc func backTapped() {
        self.dismiss(animated: true)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AppLoader.instance.hideLoaderView()
    }
}

extension WebViewVC: WKUIDelegate, WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        AppLoader.instance.showLoaderView()
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        AppLoader.instance.hideLoaderView()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        AppLoader.instance.hideLoaderView()
    }
}
