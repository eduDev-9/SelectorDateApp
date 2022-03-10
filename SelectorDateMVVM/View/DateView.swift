//
//  ContentView.swift
//  SelectorDateMVVM
//
//  Created by Edwin Ch. on 7/3/22.
//

import SwiftUI


struct DateView: View {
  
  @ObservedObject var viewModel = DateViewModel()
  
  
    var body: some View {
      
      VStack{
        HStack(spacing: 40) {
          Button(action: {  //
            print("BACK BUTTON")
            viewModel.showPreviousView()
          }, label: {
            Text("<")
          }).disabled(viewModel.disablePreviousButton)
         
          Text(viewModel.dateInView) //desdel viewModel puedo cambiar su valor
          
          Button(action: {
            print("NEXT BUTTON")
            viewModel.showNextView()
          }, label: {
            Text(">")
          }).disabled(viewModel.disableNextButton)
        }// Fin HStack
        
        HStack{
          Text("dataCost: \(viewModel.modeloInView!.datosCost)")
          
        }
                
      }//fin VStack 
      

    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView()
    }
}



//      NavigationView {
//        List(viewModel.ListDates, id: \.self) { item in
//          Text("\(item.dateString)")
//          Text(viewModel.getDateFormattered(item: item.dateString) ?? "")
//        }.navigationBarTitle("SelectorDate")
//          .onAppear{
//            self.viewModel.fetchData()
//          }
//      }
