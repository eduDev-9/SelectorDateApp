//
//  DateViewModel.swift
//  SelectorDateMVVM
//
//  Created by Edwin Ch. on 7/3/22.
//

import Foundation
import Combine


class DateViewModel: ObservableObject {
  private let url = "..."
  private var task: AnyCancellable?
  
  //  @Published var ListDates: [DateModel] = []
  
//  private var listDatesMock: [String]   =  ["ENERO 2021", "FEBRERO 2021", "MARZO 2021", "ENERO 2O22", "FEBRERO 2022", "MARZO 2022"]
  
  private var listPreviousMonths: [String] = [] // lo inicializo en el init
  
  
  @Published var disableNextButton: Bool  = false
  @Published var disablePreviousButton: Bool =  false
  
  @Published var dateInView : String = ""
  
  private var dateNowInVM: String = ""
  
  private var numberOfMonths = 12
  
  init() {
    print("EACH_DataViewModel")

    dateNowInVM = self.getDateActualFormatted()!
    listPreviousMonths = self.getListPreviousMonths()
    
    //estado inicial View
    self.getInitView()
  
    
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
//    print("EACH_nextDate: \(dateInView)")
    
    if dateInView == "March 2022" {
      disableNextButton = true
      disablePreviousButton = false //lo dejas tal cual
    } else {
      print("false")
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
      disableNextButton = false
      disablePreviousButton = true
    } else {
      print("False")
      disableNextButton = false
      disablePreviousButton = false
    }
    
    
  }
  
  
  //  func fetchData() {
  //    task = URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
  //          .map { $0.data }
  //          .decode(type: [DateModel].self, decoder: JSONDecoder())
  //          .replaceError(with: [])
  //          .eraseToAnyPublisher()
  //          .receive(on: RunLoop.main)
  //          .assign(to: \DateViewModel.ListDates, on: self)
  //
  //    print("EACH_\(ListDates)")
  //  }
  
  
  
}
