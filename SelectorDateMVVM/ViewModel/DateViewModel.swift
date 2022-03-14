//
//  DateViewModel.swift
//  SelectorDateMVVM
//
//  Created by Edwin Ch. on 7/3/22.
//

import Foundation
import Combine


class DateViewModel: ObservableObject {
  private var url: String =  ""
  private var task: AnyCancellable?
  
  private var listPreviousMonths: [String] = []
  
  
  @Published var disableNextButton: Bool  = false
  @Published var disablePreviousButton: Bool =  false
  
  @Published var dateInView : String = ""
  
  private var dateNowInVM: String = ""
  
  private var numberOfMonths = 12
  
  @Published var listDataInView : [String]  = []
  private var listDataInVM : [MobileUptake] = []
  
  @Published var modeloInView : MobileUptake?
  private var modeloInVM : MobileUptake?
  
  
  
  init() {
    
    self.dateNowInVM = self.getDateActualFormatted()!
    self.listPreviousMonths = self.getListPreviousMonths()
    
    self.getInitView()
    
    self.modeloInView = self.fecthDataMock(dateconsumo: dateNowInVM)
  }
  

  func fecthDataMock(dateconsumo: String) -> MobileUptake {

    let quidmobil : String = ""
   
    if dateconsumo == "March 2022" {
      self.url = "https://apidispmovilesdev.ahimas.es:12208/api/v1/extramobile/\(quidmobil)/\(dateconsumo)"
      self.modeloInVM = MobileUptake(voiceCost: 0, voiceMinute: 0, voiceTotal: 0, datosTotal: 0, datosCost: 0, datosMB: 0, smsCost: 0, smsCount: 0, smsTotal: 0, lastUpdate: "", voiceUnlimited: 0, guidMobile: quidmobil)
    } else {
      self.url = "https://apidispmovilesdev.ahimas.es:12208/api/v1/extramobile/\(quidmobil)/\(dateconsumo)"
      self.modeloInVM =  MobileUptake(voiceCost: 1, voiceMinute: 1, voiceTotal: 1, datosTotal: 1, datosCost: 1, datosMB: 1, smsCost: 1, smsCount: 1, smsTotal: 1, lastUpdate: "", voiceUnlimited: 1, guidMobile: quidmobil)
    }
    modeloInView = modeloInVM
    
    return modeloInView!
  }

  
  func getInitView(){
    dateInView = self.dateNowInVM
    disableNextButton = true
    disablePreviousButton = false
  }
  
  
  func getListPreviousMonths() -> [String] {
    var listData : [String] = []
 
    listData.append(dateNowInVM)
    
    let dateNow = Date()
    var nextMonthDateString: String = ""
    var listToSort: [String] = []

    
    var i = numberOfMonths
    
    while i > 0 {
      let nextMonthDate = Calendar.current.date(byAdding: .month, value: -i, to: dateNow )!
      nextMonthDateString = self.getDateFormattered(item: nextMonthDate)!
      listToSort.append(nextMonthDateString)
      i = i - 1
    }
    
    listData += Array(listToSort.reversed())

    return listData
  }
  
  func getDateActualFormatted() -> String? {
    
    let dateNow = Date()
    
    let formatter2 = DateFormatter()
    formatter2.dateFormat = "MMMM yyyy"
    
    let dateNowString = formatter2.string(from: dateNow)
    
    return dateNowString
  }
  
 
  func getDateFormattered(item: Date) -> String? {
    
 
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "MMMM yyyy"
    
    let datePrintString = dateFormatterPrint.string(from: item)
    
    return datePrintString
  }
  

  func showNextView(){

    let index = self.listPreviousMonths.firstIndex(of: dateInView)!
    
    dateInView = listPreviousMonths[index-1]
    
    if dateInView == "March 2022" {
      modeloInView = self.fecthDataMock(dateconsumo: dateInView)
      disableNextButton = true
      disablePreviousButton = false //lo dejas tal cual
    } else {
      modeloInView = self.fecthDataMock(dateconsumo: dateInView)
      disableNextButton = false
      disablePreviousButton = false
    }
    
    
  }
  
  func showPreviousView(){
    
    let index = self.listPreviousMonths.firstIndex(of: dateInView)!
    dateInView = listPreviousMonths[index+1]
        
    if dateInView == "March 2021" {
      modeloInView = self.fecthDataMock(dateconsumo: dateInView)
      disableNextButton = false
      disablePreviousButton = true
    } else {
      modeloInView = self.fecthDataMock(dateconsumo: dateInView)
      disableNextButton = false
      disablePreviousButton = false
    }
    
    
  }
  
}
