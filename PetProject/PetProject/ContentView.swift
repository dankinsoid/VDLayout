import SwiftUI
import VDLayout

struct ContentView: View {

	@State private var value = 0.0
	
	var body: some View {
		VStack {
			Spacer()
			HStack {
				Color.red
					.frame(width: value)
				
				UIKitView {
					UILabel("Text dsdas sd fsdf sdf s dfsfd sd sdf sd fsf sd fsd fs dfs d fs dfs df s dfs df ").chain
						.multiline()
						.textColor(.white)
						.padding(10)
						.padding(1)
						.backgroundColor(UIColor.systemBlue)
						.cornerRadius(10)
						.padding(20)
						.backgroundColor(UIColor.systemGreen)
						.cornerRadius(30)
				}
				.uiKitViewFixedSize(.vertical)
			}
			Slider(value: $value, in: 0...300)
		}
		.padding()
	}
}

struct ContentView_Previews: PreviewProvider {
	
	static var previews: some View {
		ContentView()
	}
}
