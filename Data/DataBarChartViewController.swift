//  DataBarChartViewController.swift

import Charts
import RealmSwift
import UIKit

class DataBarChartViewController: UIViewController, ChartViewDelegate {
    
    var noDataLabel: UILabel!
    var barChartView: BarChartView!
    var year: [String] = []
    var num: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.baseColor
        setupNoDataLabel()
        loadData()
        setupBarChartView()
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
        
        let numOfLogAnime = realm.objects(NumOfLogAnime.self).sorted(byKeyPath: "year", ascending: false)
        
        let yearRange = [numOfLogAnime.last?.year, numOfLogAnime.first?.year]
        
        for i in (yearRange[0] ?? 0) ... (yearRange[1] ?? 0)  {
            year.insert(String(i), at: 0)
            
            let numOfLogAnime = realm.objects(NumOfLogAnime.self).filter("year == %@", i).first
            
            if numOfLogAnime == nil {
                num.insert(0, at: 0)
            } else {
                num.insert(numOfLogAnime!.num, at: 0)
            }
        }
    }
    
    func setupBarChartView() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        let tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        
        barChartView = BarChartView(frame: CGRect(x: 10,
                                                  y: statusBarHeight + navigationBarHeight + 30,
                                                  width: view.frame.width - 20,
                                                  height: view.frame.height - statusBarHeight - navigationBarHeight - tabBarHeight - 60))
        barChartView.delegate = self
        barChartView.noDataText = "No Data"
        barChartView.backgroundColor = Theme.baseColor
        barChartView.dragEnabled = true
        barChartView.pinchZoomEnabled = true
        barChartView.drawBarShadowEnabled = false
        barChartView.legend.enabled = false
        barChartView.animate(yAxisDuration: 2)
        
        let formatter = BarChartFormatter()
        formatter.setValues(values: year)
        barChartView.xAxis.valueFormatter = formatter
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.granularity = 1.0
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelTextColor = Theme.baseLetterColor
        
        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.granularity = 1.0
        barChartView.leftAxis.axisLineColor = Theme.baseLetterColor
        barChartView.leftAxis.gridColor = Theme.baseLetterColor
        barChartView.leftAxis.labelTextColor = Theme.baseLetterColor
        
        barChartView.rightAxis.axisMinimum = 0
        barChartView.rightAxis.granularity = 1.0
        barChartView.rightAxis.axisLineColor = Theme.baseLetterColor
        barChartView.rightAxis.gridColor = Theme.baseLetterColor
        barChartView.rightAxis.labelTextColor = Theme.baseLetterColor
        
        let marker = XYMarkerView(color: UIColor(white: 30/250, alpha: 1),
                                  font: .systemFont(ofSize: 12),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: barChartView.xAxis.valueFormatter!)
        marker.chartView = barChartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        barChartView.marker = marker
        
        setupBarChartViewData()
        
        view.addSubview(barChartView)
    }
    
    func setupBarChartViewData() {
        var entries: [BarChartDataEntry] = []
        
        for i in 0 ..< year.count {
            entries.append(BarChartDataEntry(x: Double(i), y: Double(num[i])))
        }
        
        let dataSet = BarChartDataSet(entries: entries, label: nil)
        dataSet.drawValuesEnabled = false
        dataSet.colors = []
        
        for i in 0 ..< dataSet.count {
            dataSet.colors.append(setColor(value: dataSet[i].y))
        }
        
        barChartView.data = BarChartData(dataSet: dataSet)
    }
    
    func setColor(value: Double) -> UIColor {
        if value < 11 {
            return UIColor(red: 51/255, green: 204/255, blue: 51/255, alpha: 1)
        } else if value < 21 {
            return UIColor(red: 244/255, green: 204/255, blue: 0/255, alpha: 1)
        } else if value < 31 {
            return UIColor(red: 244/255, green: 124/255, blue: 5/255, alpha: 1)
        } else {
            return UIColor(red: 212/255, green: 60/255, blue: 52/255, alpha: 1)
        }
    }
    
    func dataExistCheck() {
        let realm = try! Realm()
        
        let logAnimeData = realm.objects(AnimeData.self).filter("status == 'log'")
        
        if logAnimeData.count > 0 {
            noDataLabel.isHidden = true
            barChartView.isHidden = false
        } else {
            noDataLabel.isHidden = false
            barChartView.isHidden = true
        }
    }
}
