//
//  ContentView.swift
//  DateField
//
//  Created by Данил Войдилов on 27.01.2022.
//

import SwiftUI
import VDKit

struct ContentView: View {
	@State var date: Date? = Date()
	@State private var isPresented = false
	
	var body: some View {
		Text(date?.string("dd.MM.y HH:mm") ?? "")
		
		DateField($date)
			.dateField(format: "\(.dd) \(.month) \(.y)")
			.frame(maxWidth: .infinity)
			.frame(height: 60)
			.accentColor(.purple)
		
		Button("Button") {
			isPresented.toggle()
		}.sheet(isPresented: $isPresented) {
			
		} content: {
			ContentView()
		}

//			.font(.system(size: 30))
//			.background(Color.red)
	}
}

//struct V1 {
//	var body: Any {
//		V2()
//			.transition(
//				.asymmetric(
//					insertion: .move(edge: .right),
//					removal: .offset(x: -30%)
//				)
//			)
//	}
//}
//
//struct V2 {
//
//}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
