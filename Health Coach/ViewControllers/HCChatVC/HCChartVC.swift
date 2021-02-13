//
//  HCChartVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 31/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
import Charts
import RangeSeekSlider
import DatePickerDialog
import HGCircularSlider

class HCChartVC: UIViewController , IAxisValueFormatter  {
    @IBOutlet weak var barChartView : BarChartView!
    @IBOutlet weak var monthlyBarChartView: BarChartView!
    @IBOutlet weak var yearlyBarChartView: BarChartView!

    
    var userInfo                     :       UserDetail?
    @IBOutlet fileprivate weak var selectMinMax : RangeSeekSlider!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCurrentDate : UILabel!
    var dateFormatted : String?

    @IBOutlet weak var viewOfWeek: UIView!
    @IBOutlet weak var viewOfMonth: UIView!
    @IBOutlet weak var viewOfYear: UIView!

    @IBOutlet weak var btnWeek: UIButton!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var btnYear: UIButton!

    var selectMax : Int?
    var selectMin  : Int?
    
    var dateOfFood = Calendar.current.startOfDay(for: Date())
    var months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    @IBOutlet weak var lblSelectDate: UILabel!
    @IBOutlet weak var viewOfPop: UIView!
    @IBOutlet weak var viewOfTime: UIView!

    // Set the Time
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var bedtimeLabel: UILabel!
    @IBOutlet weak var wakeLabel: UILabel!
    @IBOutlet weak var rangeCircularSlider: RangeCircularSlider!
    @IBOutlet weak var clockFormatSegmentedControl: UISegmentedControl!
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter
    }()

    
    var xaxisValue: [String] = []
    var hoursGlasses : [Double] = []
    weak var valueFormatter: IValueFormatter?
    var currentDate = Date()
    var dateOFCurrent : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        valueFormatter = self
        
        barChartView.gridBackgroundColor = .white
        monthlyBarChartView.gridBackgroundColor = .white
        yearlyBarChartView.gridBackgroundColor = .white

        viewOfPop.isHidden = true
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        
        dateOFCurrent = format.string(from: currentDate)
        lblSelectDate.text = dateOFCurrent
//        self.selectMin = 6
//        self.selectMax = 18
        
        selectMinMax.delegate = self
        selectMinMax.disableRange = true
        selectMinMax.enableStep = true
        
//        selectMinMax.selectedMinValue = 0.0
        
        
        dateFormatted = format.string(from: dateOfFood)
        btnWeek.isSelected = true
        btnMonth.isSelected = false
        btnYear.isSelected = false
        viewOfWeek.backgroundColor = UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0)
        viewOfMonth.backgroundColor = UIColor.clear
        viewOfYear.backgroundColor = UIColor.clear
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MMMM-dd"
        self.dateFormatted = dateFormatterGet.string(from: self.dateOfFood)
        
        lblCurrentDate.text = "Today , \(self.dateFormatted!)"
        let firstName = UserDefaults.standard.string(forKey: "firstName")
        lblName.text = "\(firstName!) Sleep"
        
   //     selectMinMax.minValue = CGFloat("6 pm")
  //      selectMinMax.maxValue = CGFloat("6 am")
        print(Date().dayOfWeek()!)

        for (_ , obj) in (userInfo?.sleep?.weeklyData?.enumerated())! {
            if (Date().dayOfWeek()! == obj.day) {
                xaxisValue.append("Today")
            } else {
                xaxisValue.append(obj.day!)
            }
            hoursGlasses.append(Double(obj.hours ?? 0))
        }
        setupView()
        
        rangeCircularSlider.startThumbImage = UIImage(named: "Bedtime")
        rangeCircularSlider.endThumbImage = UIImage(named: "Wake")
//
        let dayInSeconds = 24 * 60 * 60
        rangeCircularSlider.maximumValue = CGFloat(dayInSeconds)
        
        rangeCircularSlider.startPointValue = 1 * 60 * 60
        rangeCircularSlider.endPointValue = 8 * 60 * 60

        updateTexts(rangeCircularSlider)

        
    }
    
    @IBAction func updateTexts(_ sender: AnyObject) {
        
        adjustValue(value: &rangeCircularSlider.startPointValue)
        adjustValue(value: &rangeCircularSlider.endPointValue)

        
        let bedtime = TimeInterval(rangeCircularSlider.startPointValue)
        let bedtimeDate = Date(timeIntervalSinceReferenceDate: bedtime)
        bedtimeLabel.text = dateFormatter.string(from: bedtimeDate)
        
        let wake = TimeInterval(rangeCircularSlider.endPointValue)
        let wakeDate = Date(timeIntervalSinceReferenceDate: wake)
        wakeLabel.text = dateFormatter.string(from: wakeDate)
        
        let duration = wake - bedtime
        let durationDate = Date(timeIntervalSinceReferenceDate: duration)
        dateFormatter.dateFormat = "HH:mm"
        durationLabel.text = dateFormatter.string(from: durationDate)
        dateFormatter.dateFormat = "hh:mm a"
    }
    
    func adjustValue(value: inout CGFloat) {
        let minutes = value / 60
        let adjustedMinutes =  ceil(minutes / 5.0) * 5
        value = adjustedMinutes * 60
    }

    @IBAction private func btnBack_Pressed(_ sender: UIButton) {
        viewOfTime.isHidden = true
        viewOfPop.isHidden = true
    }
    
        func setupView() {
            
        if btnWeek.isSelected == true {
            barChartView.isHidden = false
            monthlyBarChartView.isHidden = true
            yearlyBarChartView.isHidden = true

            barChartView.animate(yAxisDuration: 2.0)
            barChartView.pinchZoomEnabled = false
//               barChartView.drawBarShadowEnabled = false
            barChartView.drawBordersEnabled = false
            barChartView.doubleTapToZoomEnabled = false
            barChartView.drawGridBackgroundEnabled = true
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
//               barChartView.drawBarShadowEnabled = false
            monthlyBarChartView.drawBordersEnabled = false
            monthlyBarChartView.doubleTapToZoomEnabled = false
            monthlyBarChartView.drawGridBackgroundEnabled = true
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
//               barChartView.drawBarShadowEnabled = false
            yearlyBarChartView.drawBordersEnabled = false
            yearlyBarChartView.doubleTapToZoomEnabled = false
            yearlyBarChartView.drawGridBackgroundEnabled = true
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
                barChartView.setScaleMinima(6.0, scaleY: 0.0)

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
//          barChartView.clearValues()
//          barChartView.noDataText = "You need to provide data for the chart."
////          var dataEntries: [BarChartDataEntry] = []
////            var dataEntries : [LineChartData] = []
//            var dataEntries: [ChartDataEntry] = []
//
////            let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
//
//          for i in 0..<dataPoints.count {
//            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[i]))
//
////            let dataEntry = LineChartData(x: Double(i), y: Double(values[i]))
//            dataEntries.append(dataEntry)
//          }
//
////          let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
////          let chartData = BarChartData(dataSet: chartDataSet)
////          barChartView.data = chartData
////
//
//            let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "")
//            let lineChartData = LineChartData(dataSet: lineChartDataSet)
////            let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
//            barChartView.data = lineChartData
//            lineChartDataSet.valueFont = UIFont(name: "Montserrat-Regular", size: 8)!
//            lineChartDataSet.valueColors = [UIColor(red: 0/255.0, green: 50/255.0, blue: 100/255.0, alpha: 1)]
//            barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xaxisValue)
//            barChartView.data?.setValueFormatter(valueFormatter!)
//            barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutQuart)
//            lineChartDataSet.colors = [UIColor(red: 10/255, green: 194/255, blue: 216/255, alpha: 1)]


            
        }
    
    func getFormattedDate(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: string)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }

    
    @IBAction func btnSelectDate_Pressed(_ sender: UIButton) {
                let currentDate = Date()
                var dateComponents = DateComponents()
                dateComponents.month = 1970
                let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
            
                let datePicker = DatePickerDialog(textColor: .black,
                                 buttonColor: .black,
                                 font: UIFont.boldSystemFont(ofSize: 17),
                                 showCancelButton: true)
                                 datePicker.show("",
                                    doneButtonTitle: "Done",
                                    cancelButtonTitle: "Cancel",
                                    minimumDate: threeMonthAgo,
                                    maximumDate: currentDate,
                                    datePickerMode: .date) { (date) in
                                if let dt = date {
                                    let dateFormatterGet = DateFormatter()
        //                                          self.dateOfFood = getDate(dayDifference: 1, selectDate: self.dateOfFood)
                                    self.dateOfFood = dt
                                    dateFormatterGet.dateFormat = "yyyy-MM-dd"
                                     self.dateOFCurrent  = dateFormatterGet.string(from: self.dateOfFood)
                                    self.lblSelectDate.text = self.getFormattedDate(string: self.dateOFCurrent!)
                                    self.lblCurrentDate.text = self.dateOFCurrent
                                        
//                                    dateOFCurrent

            }
          }
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

        for (_ , obj) in (userInfo?.sleep?.weeklyData?.enumerated())! {
            if (Date().dayOfWeek()! == obj.day) {
                xaxisValue.append("Today")
            } else {
                xaxisValue.append(obj.day!)
            }
            hoursGlasses.append(Double(obj.hours ?? 0))
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

        for (_ , obj) in (userInfo?.sleep?.monthly_data?.enumerated())! {
            let weekValue = "week \(obj.week!)"
            xaxisValue.append(weekValue)
            hoursGlasses.append(Double(obj.total!))
        }
        setupView()

//        btnMonth.setTitleColor(UIColor(named: "#40D6E9"), for: .normal)
//        btnWeek.setTitleColor(UIColor.lightGray, for: .normal)
//        btnYear.setTitleColor(UIColor.lightGray, for: .normal)
        
//          btnMonth.titleLabel?.textColor = UIColor(named: "#40D6E9")
//          btnWeek.titleLabel?.textColor = UIColor.lightGray
//          btnYear.titleLabel?.textColor = UIColor.lightGray
//          setChartData()
//        setChartMonthly(dataPoints: (userInfo?.sleep!.monthly_data)!, values: (userInfo?.sleep!.monthly_data)!)

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

        for (_ , obj) in (userInfo?.sleep?.yearlyData?.enumerated())! {
            
            if (Date().monthAsString() == obj.month) {
                xaxisValue.append("Current")
            } else {
                xaxisValue.append(obj.month!)
            }
            hoursGlasses.append(Double(obj.total!))
        }
        setupView()
    }
    
    @IBAction private func btnSetSleepTime_Pressed(_ sender : UIButton) {
            self.viewOfPop.isHidden = false
            viewOfTime.isHidden = false
    }

    
    @IBAction private func btnCross(_ sender : UIButton) {
        self.viewOfPop.isHidden = true
    }
    
    @IBAction private func btnSave_Pressed(_ sender : UIButton) {
        let userId = UserDefaults.standard.string(forKey: "id")
        let selectMaximum = wakeLabel.text ?? ""
        let selectManimum = bedtimeLabel.text ?? ""

        let loginParam =      [ "user_id"             :  userId! ,
                                "timefrom"            :  selectManimum ,
                                "timeto"              :  selectMaximum  ,
                                "date"                :  dateOFCurrent!
                              ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: ADDSLEEP , isLoaderShow: true, serviceType: "Water Today", modelType: AddSleep.self, success: { [weak self] (response) in
            guard let this = self else {
                return
            }
            let responseObj = response as? AddSleep
            if responseObj!.success == true {
//                self!.showAlert(title: KMessageTitle , message: responseObj!.message ?? responseObj!.msg!  , controller: self)
                self?.showToast(responseObj!.message ?? responseObj!.msg!)
                self?.viewOfPop.isHidden = true
                self?.viewOfTime.isHidden = true
                this.userInfo?.sleep = nil
                this.userInfo?.sleep = responseObj?.data
                if this.btnWeek.isSelected == true {
                    this.xaxisValue = []
                    this.hoursGlasses = []

                    for (_ , obj) in (this.userInfo?.sleep?.weeklyData?.enumerated())! {
                        if (Date().dayOfWeek()! == obj.day) {
                            this.xaxisValue.append("Today")
                        } else {
                            this.xaxisValue.append(obj.day!)
                        }
                        this.hoursGlasses.append(Double(obj.hours ?? 0))
                    }
                    this.barChartView.clearValues()
//                    this.xaxisValue = []
//                    this.hoursGlasses = []

                    this.setupView()
                } else if this.btnMonth.isSelected == true {
                    this.xaxisValue = []
                    this.hoursGlasses = []

                    for (_ , obj) in (this.userInfo?.sleep?.monthly_data?.enumerated())! {
                        let weekValue = "week \(obj.week!)"
                        this.xaxisValue.append(weekValue)
                        this.hoursGlasses.append(Double(obj.total!))
                    }
                    this.barChartView.clearValues()
                    this.setupView()
                } else if this.btnYear.isSelected == true {
                    this.xaxisValue = []
                    this.hoursGlasses = []

                    for (_ , obj) in (this.userInfo?.sleep?.yearlyData?.enumerated())! {
                        if (Date().monthAsString() == obj.month) {
                            this.xaxisValue.append("Current")
                        } else {
                            this.xaxisValue.append(obj.month!)
                        }
                        this.hoursGlasses.append(Double(obj.total!))
                    }
                    this.barChartView.clearValues()
//                    this.xaxisValue = []
//                    this.hoursGlasses = []

                    this.setupView()
                }
                
                
//                self!.updateChartData()
            }
            else {
                self!.showAlert(title: KMessageTitle , message: responseObj!.message!, controller: self)
            }
            }, fail: { (error) in
        }, showHUD: true)
    }
    
    func getDate(dayDifference: Int , selectDate : Date) -> Date {
        var components = DateComponents()
        components.day = dayDifference
        return Calendar.current.date(byAdding: components, to: selectDate)!
    }

    @IBAction private func btnIncrementDate(_ sender : UIButton) {
        let dateOfCurrent = Calendar.current.startOfDay(for: Date())
        if self.dateOfFood < dateOfCurrent as Date {
            let dateFormatterGet = DateFormatter()
            self.dateOfFood = getDate(dayDifference: 1, selectDate: self.dateOfFood)
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            self.dateFormatted = dateFormatterGet.string(from: self.dateOfFood)
            self.lblSelectDate.text = self.dateFormatted
            self.lblCurrentDate.text = self.dateFormatted
            self.dateOFCurrent = self.dateFormatted
//            let userId = UserDefaults.standard.string(forKey: "id")
//            let params =  [
//                "userid"                             :  userId! ,
//                "date"                               :  self.dateFormatted! ,
//                ] as [String : Any]
            
//            if isFoodOrKitchen == false {
//                getKitchOrFoodItem(params: params, serviceName: GETFOOD, isFoodItemSelect: isFoodOrKitchen)
//            } else if isKitchenItemClick == true  {
//                getKitchOrFoodItem(params: params, serviceName: GETKITCHEN, isFoodItemSelect: isFoodOrKitchen )
//            }
         }
        
    }
    
    @IBAction private func btnDecrementDate(_ sender : UIButton) {
        self.dateOfFood = getDate(dayDifference: -1 , selectDate: dateOfFood)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        self.dateFormatted = dateFormatterGet.string(from: self.dateOfFood)
        self.lblSelectDate.text = self.dateFormatted
        self.lblSelectDate.text = self.dateFormatted
        self.lblCurrentDate.text = self.dateFormatted
        self.dateOFCurrent = self.dateFormatted

//        let params =  [
//            "userid"                             :  userId! ,
//            "date"                               :  self.dateFormatted! ,
//            ] as [String : Any]
//
        
    }

    
}

extension HCChartVC : ChartViewDelegate {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return (self.userInfo?.sleep?.monthly_data![Int(value)].week)!

//        return months[Int(value) % months.count]
//        return userInfo?.sleep?.weeklyData![Int(value) % (userInfo?.sleep!.weeklyData!.count)!]
    }
}

extension HCChartVC: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        self.selectMax = Int(maxValue)
        self.selectMin = Int(minValue)
    }

    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }

    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}

extension HCChartVC: IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
//        print(value)
        switch value {
        default:
            return "\(value) Hours"
        }
    }
}
