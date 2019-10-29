//  WebBaseViewController.swift

import UIKit
import WebKit

class WebBaseViewController: UIViewController {

    var cancelBtn: UIButton!
    var webView: WKWebView!
    
    func setup(forResource: String) {
        view.backgroundColor = .white
        setupCancelBtn()
        setupWebView()
        loadPage(forResource: forResource)
    }
    
    func setupCancelBtn() {
        cancelBtn = UIButton(type: .system)
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.frame = CGRect(x: 5,
                                 y: 30,
                                 width: 100,
                                 height: 60)
        cancelBtn.addTarget(self, action: #selector(cancelBtnEvent(_:)), for: .touchUpInside)
        
        view.addSubview(cancelBtn)
    }
    
    func setupWebView() {
        let frame = CGRect(x: 0,
                           y: cancelBtn.frame.maxY + 10,
                           width: view.frame.width,
                           height: view.frame.height - cancelBtn.frame.maxY - 10)
        
        let configuration = WKWebViewConfiguration()
        
        webView = WKWebView(frame: frame,
                            configuration: configuration)
        
        view.addSubview(webView)
    }
    
    func loadPage(forResource: String) {
        let url = URL(string: "https://fukky21.github.io/AniPocket/" + forResource)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    @objc func cancelBtnEvent(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
