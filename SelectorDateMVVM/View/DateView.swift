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
          Button(action: { 
            
            viewModel.showPreviousView()
          }, label: {
            Text("<")
          }).disabled(viewModel.disablePreviousButton)
         
          Text(viewModel.dateInView)
          
          Button(action: {
            viewModel.showNextView()
          }, label: {
            Text(">")
          }).disabled(viewModel.disableNextButton)
        }
        
        HStack{
          Text("dataCost: \(viewModel.modeloInView!.datosCost)")
        }
                
      }
      

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
