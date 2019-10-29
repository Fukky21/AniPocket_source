//  SettingUsageViewController.swift

import UIKit

class SettingUsageViewController: UIViewController {
    
    var cancelBtn: UIButton!
    var pageControl: UIPageControl!
    var scrollView: UIScrollView!
    let numOfPages = 7

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCancelBtn()
        setupPageControl()
        setupScroll()
        createPages()
    }
    
    func setupCancelBtn() {
        cancelBtn = UIButton(type: .system)
        cancelBtn.frame = CGRect(x: 5,
                                 y: 30,
                                 width: 100,
                                 height: 60)
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnEvent(_:)), for: .touchUpInside)
        
        view.addSubview(cancelBtn)
    }
    
    func setupPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,
                                                  y: cancelBtn.frame.maxY + 10,
                                                  width: view.frame.width,
                                                  height: 30))
        pageControl.numberOfPages = numOfPages
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        
        view.addSubview(pageControl)
    }
    
    func setupScroll() {
        scrollView = UIScrollView(frame: CGRect(x: 0,
                                                y: pageControl.frame.maxY + 10,
                                                width: view.frame.width,
                                                height: view.frame.height - pageControl.frame.maxY - 10))
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(numOfPages),
                                        height: view.frame.height - pageControl.frame.maxY - 10)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        
        view.addSubview(scrollView)
    }
    
    func createPages() {
        let usageView1 = UsageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: scrollView.frame.width,
                                                  height: scrollView.frame.height))
        usageView1.setup(imgName: "usage01",
                         japaneseText: "AniPocketには5つの機能があります。",
                         englishText: "AniPocket has 5 functions.")
        
        let usageView2 = UsageView(frame: CGRect(x: scrollView.frame.width,
                                                  y: 0,
                                                  width: scrollView.frame.width,
                                                  height: scrollView.frame.height))
        usageView2.setup(imgName: "usage02",
                         japaneseText: "「見ているアニメ」ではあなたが今見ているアニメを管理できます。",
                         englishText: "In \"Watching\", you can control animes you are watching.")
        
        let usageView3 = UsageView(frame: CGRect(x: scrollView.frame.width * 2,
                                                  y: 0,
                                                  width: scrollView.frame.width,
                                                  height: scrollView.frame.height))
        usageView3.setup(imgName: "usage03",
                         japaneseText: "見ているアニメ(過去作品)のセルをタップすると、何話まで見終わったかを管理できます。",
                         englishText: "By tapping the cell in Watching(Past), you can control how many episodes you have watched.")
        
        let usageView4 = UsageView(frame: CGRect(x: scrollView.frame.width * 3,
                                                  y: 0,
                                                  width: scrollView.frame.width,
                                                  height: scrollView.frame.height))
        usageView4.setup(imgName: "usage04",
                         japaneseText: "「ログ」ではあなたがこれまでに見てきたアニメを管理できます。",
                         englishText: "In \"Log\", you can control animes you have wathched.")
        
        let usageView5 = UsageView(frame: CGRect(x: scrollView.frame.width * 4,
                                                  y: 0,
                                                  width: scrollView.frame.width,
                                                  height: scrollView.frame.height))
        usageView5.setup(imgName: "usage05",
                         japaneseText: "年別にアニメをまとめて管理できます。",
                         englishText: "You can control animes by year.")
        
        let usageView6 = UsageView(frame: CGRect(x: scrollView.frame.width * 5,
                                                  y: 0,
                                                  width: scrollView.frame.width,
                                                  height: scrollView.frame.height))
        usageView6.setup(imgName: "usage06",
                         japaneseText: "「あとで見るアニメ」ではあなたがこれから見たいと思っているアニメを管理できます。",
                         englishText: "In \"Watch Later\", you can control animes you want to watch.")
        
        let usageView7 = UsageView(frame: CGRect(x: scrollView.frame.width * 6,
                                                 y: 0,
                                                 width: scrollView.frame.width,
                                                 height: scrollView.frame.height))
        usageView7.setup(imgName: "usage07",
                         japaneseText: "「データ」ではあなたが追加したアニメの統計データを確認できます。",
                         englishText: "In \"Data\", you can check the statistical data of animes you added.")
        
        scrollView.addSubview(usageView1)
        scrollView.addSubview(usageView2)
        scrollView.addSubview(usageView3)
        scrollView.addSubview(usageView4)
        scrollView.addSubview(usageView5)
        scrollView.addSubview(usageView6)
        scrollView.addSubview(usageView7)
    }
    
    @objc func cancelBtnEvent(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension SettingUsageViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}
