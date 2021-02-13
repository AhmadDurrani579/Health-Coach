//
//  HCExerciseVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 26/09/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
import Charts
//private let ITEM_COUNT = 12

class HCExerciseVC: UIViewController {
    
    @IBOutlet weak var viewOfWeek: UIView!
    @IBOutlet weak var viewOfMonth: UIView!
    @IBOutlet weak var viewOfYear: UIView!

    @IBOutlet weak var btnWeek: UIButton!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var btnYear: UIButton!
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var monthlyBarChartView: BarChartView!
    @IBOutlet weak var yearlyBarChartView: BarChartView!

    var userInfo                     :       UserDetail?

//    let players = ["Ozil", "Ramsey", "Laca", "Auba", "Xhaka", "Torreira"]


//    @IBOutlet weak var combinedChartView: CombinedChartView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet var chartView : CombinedChartView!
    
    var xaxisValue: [String] = []
    var hoursGlasses : [Double] = []
    weak var valueFormatter: IValueFormatter?

    let calendar = Calendar.current


    override func viewDidLoad() {
        super.viewDidLoad()
        valueFormatter = self
        
        barChartView.gridBackgroundColor = .white
        monthlyBarChartView.gridBackgroundColor = .white
        yearlyBarChartView.gridBackgroundColor = .white

        let firstName = UserDefaults.standard.string(forKey: "firstName")
        lblName.text = "\(firstName!) Exercise"
        
        btnWeek.isSelected = true
        btnMonth.isSelected = false
        btnYear.isSelected = false

        print(Date().dayOfWeek()!)
        
        viewOfWeek.backgroundColor = UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0)
        viewOfMonth.backgroundColor = UIColor.clear
        viewOfYear.backgroundColor = UIColor.clear
        barChartView.animate(yAxisDuration: 2.0)

//        guard ((userInfo?.exerciseReport?.weeklyData) != nil) else {
//            self.showToast("Currently No Data")
//            return
//        }
        
        for (_ , obj) in (userInfo?.exerciseReport!.weeklyData?.enumerated())! {
            if (Date().dayOfWeek()! == obj.day) {
                xaxisValue.append("Today")
            } else {
                xaxisValue.append(obj.day!)
            }
            hoursGlasses.append(Double(obj.duration ?? 0))
        }
        setupView()

    }
    
            func setupView() {
                
                if btnWeek.isSelected == true {
                    barChartView.isHidden = false
                    monthlyBarChartView.isHidden = true
                    yearlyBarChartView.isHidden = true

                    barChartView.animate(yAxisDuration: 2.0)
                    barChartView.pinchZoomEnabled = false
                    barChartView.drawBarShadowEnabled = false
                    barChartView.drawBordersEnabled = false
                    barChartView.doubleTapToZoomEnabled = false
                    barChartView.drawGridBackgroundEnabled = true
                    barChartView.setScaleMinima(6.0, scaleY: 0.0)

                    let xaxis = barChartView.xAxis
                    let formatter = CustomLabelsXAxisValueFormatter()//custom value formatter
                    formatter.labels = self.xaxisValue
                    xaxis.valueFormatter = formatter
                    xaxis.drawGridLinesEnabled = true
                    xaxis.labelPosition = .top
                    xaxis.labelPosition = . bottom
                    xaxis.labelTextColor = UIColor.black
                    xaxis.centerAxisLabelsEnabled = false
                    xaxis.axisLineColor = UIColor.black
                    xaxis.granularityEnabled = false
                    xaxis.granularity = 1.0
                    xaxis.enabled = true
                    
                    setChart(dataPoints: xaxisValue, values: hoursGlasses)
                } else if btnMonth.isSelected == true {
                    barChartView.isHidden = true
                    monthlyBarChartView.isHidden = false
                    yearlyBarChartView.isHidden = true

                    monthlyBarChartView.animate(yAxisDuration: 2.0)
                    monthlyBarChartView.pinchZoomEnabled = false
                    monthlyBarChartView.drawBarShadowEnabled = false
                    monthlyBarChartView.drawBordersEnabled = false
                    monthlyBarChartView.doubleTapToZoomEnabled = false
                    monthlyBarChartView.drawGridBackgroundEnabled = true
        //            barChartView.chartDescription?.text = "Bar Chart View"
                    let xaxis = monthlyBarChartView.xAxis
                    let formatter = CustomLabelsXAxisValueFormatter()//custom value formatter
                    formatter.labels = self.xaxisValue
                    xaxis.valueFormatter = formatter
                    xaxis.drawGridLinesEnabled = true
                    xaxis.labelPosition = .top
                    xaxis.labelPosition = . bottom
                    xaxis.labelTextColor = UIColor.black
                    xaxis.centerAxisLabelsEnabled = false
                    xaxis.axisLineColor = UIColor.black
                    xaxis.granularityEnabled = false
                    xaxis.granularity = 1.0
                    xaxis.enabled = true
                    setChart(dataPoints: xaxisValue, values: hoursGlasses)
                } else if btnYear.isSelected == true {
                    barChartView.isHidden = true
                    monthlyBarChartView.isHidden = true
                    yearlyBarChartView.isHidden = false
                    yearlyBarChartView.animate(yAxisDuration: 2.0)
                    yearlyBarChartView.pinchZoomEnabled = false
                    yearlyBarChartView.drawBarShadowEnabled = false
                    yearlyBarChartView.drawBordersEnabled = false
                    yearlyBarChartView.doubleTapToZoomEnabled = false
                    yearlyBarChartView.drawGridBackgroundEnabled = true
        //            barChartView.chartDescription?.text = "Bar Chart View"
                    let xaxis = yearlyBarChartView.xAxis
                    let formatter = CustomLabelsXAxisValueFormatter()//custom value formatter
                    formatter.labels = self.xaxisValue
                    xaxis.valueFormatter = formatter
                    xaxis.drawGridLinesEnabled = true
                    xaxis.labelPosition = .top
                    xaxis.labelPosition = . bottom
                    xaxis.labelTextColor = UIColor.black
                    xaxis.centerAxisLabelsEnabled = false
                    xaxis.axisLineColor = UIColor.black
                    xaxis.granularityEnabled = false
                    xaxis.granularity = 1.0
                    xaxis.enabled = true
                    setChart(dataPoints: xaxisValue, values: hoursGlasses)
                }

        }
            
        func setChart(dataPoints: [String], values: [Double]) {
            
            if btnWeek.isSelected == true {
                barChartView.clearValues()
                barChartView.noDataText = "You need to provide data for the chart."
                var dataEntries: [BarChartDataEntry] = []
                for i in 0..<dataPoints.count {
                  let dataaEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
                  dataEntries.append(dataaEntry)
                }
                let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
                let chartData = BarChartData(dataSet: chartDataSet)
                barChartView.data = chartData
                chartDataSet.valueFont = UIFont(name: "Montserrat-Regular", size: 8)!
                chartDataSet.valueColors = [UIColor(red: 0/255.0, green: 50/255.0, blue: 100/255.0, alpha: 1)]
                barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xaxisValue)
                barChartView.data?.setValueFormatter(valueFormatter!)
                barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutQuart)
                chartDataSet.colors = [UIColor(red: 10/255, green: 194/255, blue: 216/255, alpha: 1)]
            } else if btnMonth.isSelected == true {
                monthlyBarChartView.clearValues()
                monthlyBarChartView.noDataText = "You need to provide data for the chart."
                var dataEntries: [BarChartDataEntry] = []
                for i in 0..<dataPoints.count {
                  let dataaEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
                  dataEntries.append(dataaEntry)
                }
                let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
                let chartData = BarChartData(dataSet: chartDataSet)
                monthlyBarChartView.data = chartData
                chartDataSet.valueFont = UIFont(name: "Montserrat-Regular", size: 8)!
                chartDataSet.valueColors = [UIColor(red: 0/255.0, green: 50/255.0, blue: 100/255.0, alpha: 1)]
                monthlyBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xaxisValue)
                monthlyBarChartView.data?.setValueFormatter(valueFormatter!)
                monthlyBarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutQuart)
                chartDataSet.colors = [UIColor(red: 10/255, green: 194/255, blue: 216/255, alpha: 1)]
            } else if btnYear.isSelected == true {
                yearlyBarChartView.clearValues()
                yearlyBarChartView.noDataText = "You need to provide data for the chart."
                var dataEntries: [BarChartDataEntry] = []
                for i in 0..<dataPoints.count {
                  let dataaEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
                  dataEntries.append(dataaEntry)
                }
                let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
                let chartData = BarChartData(dataSet: chartDataSet)
                yearlyBarChartView.data = chartData
                chartDataSet.valueFont = UIFont(name: "Montserrat-Regular", size: 8)!
                chartDataSet.valueColors = [UIColor(red: 0/255.0, green: 50/255.0, blue: 100/255.0, alpha: 1)]
                yearlyBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xaxisValue)
                yearlyBarChartView.data?.setValueFormatter(valueFormatter!)
                yearlyBarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutQuart)
                chartDataSet.colors = [UIColor(red: 10/255, green: 194/255, blue: 216/255, alpha: 1)]
            }

        }

    
        func setChart(dataPoints: [WeeklyDataExercise], values: [WeeklyDataExercise]) {
    //      barChartView.noDataText = "You need to provide data for the chart."
          
            barChartView.isHidden = false
            monthlyBarChartView.isHidden = true
            yearlyBarChartView.isHidden = true

          var dataEntries: [BarChartDataEntry] = []
//            barChartView.delegate = self
          for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(values[i].duration!), y: Double(values[i].duration!))
            dataEntries.append(dataEntry)
          }
          
        
          let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
          let chartData = BarChartData(dataSet: chartDataSet)
          barChartView.data = chartData
        }
        
        func setChartMonthly(dataPoints: [MonthlyDataExercise], values: [MonthlyDataExercise]) {
        //      barChartView.noDataText = "You need to provide data for the chart."
              
            barChartView.isHidden = true
            monthlyBarChartView.isHidden = false
            yearlyBarChartView.isHidden = true

              var dataEntries: [BarChartDataEntry] = []
//                barChartView.delegate = self
              for i in 0..<dataPoints.count {
                let dataEntry = BarChartDataEntry(x: Double(values[i].total!), y: Double(values[i].total!))
              dataEntries.append(dataEntry)
             }
              
            
              let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
              let chartData = BarChartData(dataSet: chartDataSet)
              monthlyBarChartView.data = chartData
            }

        func setChartYearly(dataPoints: [YearlyDataExercise], values: [YearlyDataExercise]) {
        //      barChartView.noDataText = "You need to provide data for the chart."
              
            barChartView.isHidden = true
            monthlyBarChartView.isHidden = true
            yearlyBarChartView.isHidden = false

              var dataEntries: [BarChartDataEntry] = []
//                barChartView.delegate = self
              for i in 0..<dataPoints.count {
                let dataEntry = BarChartDataEntry(x: Double(values[i].total!), y: Double(values[i].total!))
              dataEntries.append(dataEntry)
             }
              
            
              let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
              let chartData = BarChartData(dataSet: chartDataSet)
              yearlyBarChartView.data = chartData
            }

    
        @IBAction private func weekLyChart(_ sender : UIButton) {
            sender.isSelected = !sender.isSelected
            
            viewOfMonth.backgroundColor = UIColor(named: "#40D6E9")
            viewOfWeek.backgroundColor = UIColor.lightGray
            viewOfYear.backgroundColor = UIColor.lightGray
            
            viewOfWeek.backgroundColor = UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0)
            viewOfMonth.backgroundColor = UIColor.clear
            viewOfYear.backgroundColor = UIColor.clear
            
            btnWeek.isSelected = true
            btnMonth.isSelected = false
            btnYear.isSelected = false
            xaxisValue = []
            hoursGlasses = []
//            guard ((userInfo?.exerciseReport?.weeklyData) != nil) else {
//                self.showToast("Currently No Data")
//                return
//            }
//
            for (_ , obj) in (userInfo?.exerciseReport!.weeklyData?.enumerated())! {
                if (Date().dayOfWeek()! == obj.day) {
                    xaxisValue.append("Today")
                } else {
                    xaxisValue.append(obj.day!)
                }

//
                hoursGlasses.append(Double(obj.duration ?? 0))
//                hoursGlasses.append(Double(obj.duration ?? "0")!)
            }
            setupView()
        }
        
        @IBAction private func monthlyChart(_ sender : UIButton) {
            sender.isSelected = !sender.isSelected
            
            viewOfMonth.backgroundColor = UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0)
            viewOfWeek.backgroundColor = UIColor.clear
            viewOfYear.backgroundColor = UIColor.clear
                btnWeek.isSelected = false
                btnMonth.isSelected = true
                btnYear.isSelected = false
            xaxisValue = []
            hoursGlasses = []
            for (_ , obj) in (userInfo?.exerciseReport!.monthly_data?.enumerated())! {
                let weekValue = "week \(obj.week!)"
                xaxisValue.append(weekValue)
                hoursGlasses.append(Double(obj.total!))
            }
            setupView()
          }
        
        @IBAction private func yearlyChart(_ sender : UIButton) {
            sender.isSelected = !sender.isSelected
            viewOfYear.backgroundColor = UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0)
            viewOfWeek.backgroundColor = UIColor.clear
            viewOfMonth.backgroundColor = UIColor.clear

            btnWeek.isSelected = false
            btnMonth.isSelected = false
            btnYear.isSelected = true
            xaxisValue = []
            hoursGlasses = []
            for (_ , obj) in (userInfo?.exerciseReport!.yearlyData?.enumerated())! {
                if (Date().monthAsString() == obj.month) {
                    xaxisValue.append("Current")
                } else {
                    xaxisValue.append(obj.month!)
                }
                hoursGlasses.append(Double(obj.total!))
            }
            setupView()
        }
}

extension HCExerciseVC: IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        print(value)
        
        switch value {
        default:
            return "\(value) Minutes"
        }
    }
}

extension Date {
    
    func monthAsString() -> String {
            let df = DateFormatter()
            df.setLocalizedDateFormatFromTemplate("MMMM")
            return df.string(from: self)
    }


    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
    
    
}
