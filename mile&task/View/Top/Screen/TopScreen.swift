//
//  TopScreen.swift
//  mile&task
//
//  Created by 中川 匠 on 2023/11/27.
//

import SwiftUI

struct TopScreen: View {
    @State private var targets: [Target] = []
    @State private var isLoading = false // データ取得中のフラグ
    
    var body: some View {
        ZStack {
            if isLoading { // データ取得中の場合
                ProgressView("Loading...") // ローディング表示
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(targets, id: \.id) { target in
                            Text(target.name)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    private func loadData() {
        isLoading = true // データ取得中にフラグをセット
        Task {
            do {
                targets = try await TargetRepository.getTargets()
                isLoading = false // データ取得後にフラグをオフにする
            } catch {
                print("Error fetching targets: \(error)")
                isLoading = false // エラー時もフラグをオフにする
            }
        }
    }
}

#Preview {
    TopScreen()
}
