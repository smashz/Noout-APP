import SwiftUI
import UltralyticsYOLO

let modelRemoteURL = URL(string: "https://github.com/ultralytics/yolo-ios-app/releases/download/v8.3.0/yolo26n-pose.mlpackage.zip")!
let downloader = YOLOModelDownloader()

@main
struct WorkoutApp: App {
    var body: some Scene {
        WindowGroup { ContentView() }
    }
}

struct ContentView: View {
    @State private var modelURL: URL?
    @State private var progress = 0.0
    @State private var error: String?

    var body: some View {
        Group {
            if let modelURL {
                YOLOCamera(url: modelURL, task: .pose, cameraPosition: .back)
                    .ignoresSafeArea()
            } else if let error {
                Text("Model download failed:\n\(error)").multilineTextAlignment(.center).padding()
            } else {
                ProgressView("Downloading model…", value: progress)
                    .padding()
            }
        }
        .onAppear {
            guard modelURL == nil else { return }
            downloader.download(
                from: modelRemoteURL,
                task: .pose,
                progress: { progress = $0 }
            ) { result in
                switch result {
                case .success(let url): modelURL = url
                case .failure(let err): error = err.localizedDescription
                }
            }
        }
    }
}