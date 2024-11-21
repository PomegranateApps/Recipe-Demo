//
//  WebView.swift
//  Recipes
//
//  Created by Chris DeSalvo on 11/20/24.
//

import SwiftUI
import WebKit

private class WebViewCoordinator: NSObject, WKNavigationDelegate {
	@Binding var finished: Bool

	init(finished: Binding<Bool>) {
		_finished = finished
	}
	
	func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		finished = true
	}
}

private struct WebViewInternal: UIViewRepresentable {
	let url: URL
	@Binding var finished: Bool

	func makeCoordinator() -> WebViewCoordinator {
		WebViewCoordinator(finished: $finished)
	}

	func makeUIView(context: Context) -> WKWebView {
		let webView = WKWebView()
		webView.navigationDelegate = context.coordinator
		return webView
	}

	func updateUIView(_ uiView: WKWebView, context: Context) {
		let request = URLRequest(url: url)
		uiView.load(request)
	}
}

struct WebView: View {
	var url: URL
	@State private var finished = false
	
	var body: some View {
		NavigationStack {
			ZStack {
				WebViewInternal(url: url, finished: $finished)
					
				if !finished {
					ProgressView()
				}
			}
		}
	}
}

#Preview {
	WebView(url: URL(string: RecipeService.preview().first!.url!)!)
}
