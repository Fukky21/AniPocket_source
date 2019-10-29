//  DataPieChartViewController.swift

import Charts
import RealmSwift
import UIKit

class DataPieChartViewController: UIViewController, ChartViewDelegate {
    
    var noDataLabel: UILabel!
    var pieChartView: PieChartView!
    var genreTV: UITableView!
    var num: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.baseColor
        setupNoDataLabel()
        loadData()
        setupPieChartView()
        setupGenreTV()
        dataExistCheck()
    }
    
    func setupNoDataLabel() {
        noDataLabel = UILabel(frame: CGRect(x: (view.frame.width - 200) / 2,
                                            y: (view.frame.height - 40) / 2,
                                            width: 200,
                                            height: 40))
        noDataLabel.text = "No Data"
        noDataLabel.textColor = Theme.baseLetterColor
        noDataLabel.font = .boldSystemFont(ofSize: 20)
        noDataLabel.textAlignment = .center
        
        view.addSubview(noDataLabel)
    }

    func loadData() {
        let realm = try! Realm()
        
        for i in 1 ... Language.genreList.count {
            let tmp = realm.objects(AnimeData.self).filter("status == 'log' AND genre == %@", i)
            num.append(tmp.count)
        }
    }
    
    func setupPieChartView() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        let tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        
        pieChartView = PieChartView(frame: CGRect(x: 10,
                                                  y: statusBarHeight + navigationBarHeight + 10,
                                                  width: view.frame.width - 20,
                                                  height: (view.frame.height - statusBarHeight - navigationBarHeight - tabBarHeight) * 3 / 5))
        pieChartView.delegate = self
        pieChartView.noDataText = "No Data"
        pieChartView.usePercentValuesEnabled = true
        pieChartView.holeRadiusPercent = 0.58
        pieChartView.holeColor = .gray
        pieChartView.transparentCircleRadiusPercent = 0.61
        pieChartView.drawCenterTextEnabled = true
        pieChartView.drawHoleEnabled = true
        pieChartView.rotationEnabled = true
        pieChartView.highlightPerTapEnabled = false
        pieChartView.backgroundColor = Theme.baseColor
        pieChartView.animate(xAxisDuration: 1.4)
        
        let l = pieChartView.legend
        l.orientation = .horizontal
        l.textColor = Theme.baseLetterColor
        l.formSize = 10
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.yEntrySpace = 5
        l.xOffset = 10
        l.yOffset = 10
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = .center
        
        let centerText = NSMutableAttributedString(string: Language.ratioByGenre)
        pieChartView.centerAttributedText = centerText
        
        setupPieChartViewData()
        
        view.addSubview(pieChartView)
    }
    
    func setupPieChartViewData() {
        var entries: [PieChartDataEntry] = []
        
        for i in 0 ..< Language.genreList.count {
            if num[i] != 0 {
                entries.append(PieChartDataEntry(value: Double(num[i]), label: Language.genreList[i]))
            }
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: nil)
        dataSet.colors = []
        
        let genreColors = [UIColor(red: 255/255, green: 50/255, blue: 50/255, alpha: 1),    // Action/Battle
                           UIColor(red: 0/255, green: 255/255, blue: 191/255, alpha: 1),    // SF/Fantasy/Different World
                           UIColor(red: 255/255, green: 153/255, blue: 50/255, alpha: 1),   // Comedy/Gag
                           UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1),    // Short
                           UIColor(red: 101/255, green: 178/255, blue: 255/255, alpha: 1),  // Sports/Competition
                           UIColor(red: 204/255, green: 255/255, blue: 50/255, alpha: 1),   // Drama/Youth
                           UIColor(red: 63/255, green: 255/255, blue: 0/255, alpha: 1),     // Everyday/Honobono
                           UIColor(red: 192/255, green: 160/255, blue: 62/255, alpha: 1),   // Horror/Suspense/Mystery
                           UIColor(red: 158/255, green: 139/255, blue: 217/255, alpha: 1),  // History/Military history
                           UIColor(red: 128/255, green: 154/255, blue: 49/255, alpha: 1),   // War/Military
                           UIColor(red: 255/255, green: 153/255, blue: 229/255, alpha: 1),  // Love/Romantic comedy
                           UIColor(red: 185/255, green: 167/255, blue: 240/255, alpha: 1),  // Robot/Mechanic
                           UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)]  // Other
        
        for i in 0 ..< Language.genreList.count {
            if num[i] != 0 {
                dataSet.colors.append(genreColors[i])
            }
        }
        
        pieChartView.data = PieChartData(dataSet: dataSet)
        pieChartView.data?.setValueTextColor(.black)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        pFormatter.zeroSymbol = ""
        pieChartView.data?.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
    }
    
    func setupGenreTV() {
        let tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        
        genreTV = UITableView(frame: CGRect(x: 0,
                                            y: pieChartView.frame.maxY + 5,
                                            width: view.frame.width,
                                            height: view.frame.height - pieChartView.frame.maxY - tabBarHeight - 5))
        genreTV.backgroundColor = Theme.baseColor
        genreTV.delegate = self
        genreTV.dataSource = self
        genreTV.tableFooterView = UIView(frame: .zero)
        genreTV.allowsSelection = false
        
        view.addSubview(genreTV)
    }
    
    func dataExistCheck() {
        let realm = try! Realm()
        
        let logAnimeData = realm.objects(AnimeData.self).filter("status == 'log'")
        
        if logAnimeData.count > 0 {
            noDataLabel.isHidden = true
            pieChartView.isHidden = false
            genreTV.isHidden = false
        } else {
            noDataLabel.isHidden = false
            pieChartView.isHidden = true
            genreTV.isHidden = true
        }
    }
}

extension DataPieChartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Language.genreList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = Language.genreList[indexPath.item]
        cell.textLabel?.textColor = Theme.baseLetterColor
        cell.detailTextLabel?.text = String(num[indexPath.item])
        cell.detailTextLabel?.textColor = Theme.baseLetterColor
        cell.backgroundColor = Theme.baseColor
        
        return cell
    }
}
