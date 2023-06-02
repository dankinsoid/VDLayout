import SwiftUI
import VDLayout

struct ContentView: View {
	
    var body: some View {
        VStack {
					Spacer()
					UIKitView {
						UIView.subview {
							UIView.subview {
								UILabel("Text dsdas sd fsdf sdf s dfsfd sd sdf sd fsf sd fsd fs dfs d fs dfs df s dfs df ").chain
									.multiline()
									.textColor(.white)
									.pin(.edges, 10)
							}
							.backgroundColor(UIColor.systemBlue)
							.cornerRadius(10)
							.pin(.edges, 20)
						}
						.cornerRadius(30)
						.backgroundColor(UIColor.systemGreen)
					}
					.uiKitViewFixedSize(.vertical)
					Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
