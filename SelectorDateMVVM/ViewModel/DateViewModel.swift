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
  
  private var listPreviousMonths: [String] = [] // lo inicializo en el init
  
  
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
    print("EACH_DataViewModel")
    
    dateNowInVM = self.getDateActualFormatted()!
    listPreviousMonths = self.getListPreviousMonths()
    
    //estado inicial Buttons + Text in View
    self.getInitView()
    
    //estado inicial de la componente List in View con datos mokeados
    modeloInView = self.fecthDataMock(dateconsumo: dateNowInVM)
  }
  

  func fecthDataMock(dateconsumo: String) -> MobileUptake {

    let quidmobil : String = ""
   
    if dateconsumo == "March 2022" { //initial model
      self.url = "https://apidispmovilesdev.ahimas.es:12208/api/v1/extramobile/\(quidmobil)/\(dateconsumo)"
      self.modeloInVM = MobileUptake(voiceCost: 0, voiceMinute: 0, voiceTotal: 0, datosTotal: 0, datosCost: 0, datosMB: 0, smsCost: 0, smsCount: 0, smsTotal: 0, lastUpdate: "", voiceUnlimited: 0, guidMobile: quidmobil)
    } else {
      self.url = "https://apidispmovilesdev.ahimas.es:12208/api/v1/extramobile/\(quidmobil)/\(dateconsumo)"
      self.modeloInVM =  MobileUptake(voiceCost: 1, voiceMinute: 1, voiceTotal: 1, datosTotal: 1, datosCost: 1, datosMB: 1, smsCost: 1, smsCount: 1, smsTotal: 1, lastUpdate: "", voiceUnlimited: 1, guidMobile: quidmobil)
    }
    self.modeloInView = modeloInVM
    print("EACH_modelo asociado a \(dateconsumo) -->  \(modeloInVM)")
    return modeloInView!
  }

  
  func getInitView(){ // estado inicial de la View
    print("EACH_getInitView")
    dateInView = self.dateNowInVM
    disableNextButton = true
    disablePreviousButton = false
  }
  
  
  func getListPreviousMonths() -> [String] { //despues de init
    var listData : [String] = []
    print("After init() : \(dateNowInVM)") // quiero ver su valor
    listData.append(dateNowInVM) // lo añado como 1º elemt
    
    let dateNow = Date()
    var nextMonthDateString: String = ""
    var listToSort: [String] = []

    
    var i = numberOfMonths // 12
    
    while i > 0 {
      let nextMonthDate = Calendar.current.date(byAdding: .month, value: -i, to: dateNow )!
      nextMonthDateString = self.getDateFormattered(item: nextMonthDate)!
      listToSort.append(nextMonthDateString)
      i = i - 1
    }
    
    listData += Array(listToSort.reversed())
    
    print("Resultado listData --> \(listData)")

    return listData
  }
  
  func getDateActualFormatted() -> String? {
    print("EACH_getDateActualFormatted")
    
    let dateNow = Date()  // 2022-03-09 09:15:04 +0000
    print("EACH_dateNow_sin: \(dateNow)")
    
    let formatter2 = DateFormatter()
    formatter2.dateFormat = "MMMM yyyy" //Selecciono el tipo de formato
    
    let dateNowString = formatter2.string(from: dateNow)
    print("EACH_dateNow_con: \(dateNowString)")
    
    return dateNowString
  }
  
 
  func getDateFormattered(item: Date) -> String? {
    
    //Selecciono el formato
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "MMMM yyyy"
    
    let datePrintString = dateFormatterPrint.string(from: item)
//    print("EACH_\(datePrintString)")
    
    return datePrintString
  }
  
 
  //Actions button
  func showNextView(){
    print("EACH_ shownNextView")
    let index = self.listPreviousMonths.firstIndex(of: dateInView)! //Coincide el 1º elemento -> index = 0
    
    dateInView = listPreviousMonths[index-1]
    
    if dateInView == "March 2022" {
      self.fecthDataMock(dateconsumo: dateInView)
      disableNextButton = true
      disablePreviousButton = false //lo dejas tal cual
    } else {
      print("false")
      self.fecthDataMock(dateconsumo: dateInView)
      disableNextButton = false
      disablePreviousButton = false
    }
    
    
  }
  
  func showPreviousView(){
    print("EACH_ showPreviousView")
    
    let index = self.listPreviousMonths.firstIndex(of: dateInView)!
    dateInView = listPreviousMonths[index+1]
    
    print("EACH_previousDate: \(dateInView)")
    
    if dateInView == "March 2021" {  // Si coincide con la última -> Deshabilitas la 1º componente/actualizas la 2ºcomponete/Habilitas la 3º componente
      print("True")
      self.fecthDataMock(dateconsumo: dateInView)
      //añadir fetchData....
      disableNextButton = false
      disablePreviousButton = true
    } else {
      print("False")
      self.fecthDataMock(dateconsumo: dateInView)
      disableNextButton = false
      disablePreviousButton = false
    }
    
    
  }
  
}
