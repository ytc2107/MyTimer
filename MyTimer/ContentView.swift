//
//  ContentView.swift
//  MyTimer
//
//  Created by macmini on 2025/06/02.
//

import SwiftUI

struct ContentView: View {
    // タイマー変数を作成
    @State var timerHandler: Timer?
    // カウント（経過時間）の変数を作成
    @State var count = 0
    // 永続化する秒数設定
    @AppStorage("timer_value") var timerValue = 10
    // アラート表示の有無
    @State var isShowAlert: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                // 背景画像
                Image(.backgroundTimer)
                // リサイズする
                    .resizable()
                // セーフエリアを超えて画面全体に背景を配置する
                    .ignoresSafeArea()
                // アスペクト比を維持して、短辺基準に収まるように配置
                    .scaledToFill()

                // 垂直にレイアウト（縦方向にレイアウト）
                // View（部品）間の間隔を30にする
                VStack(spacing: 30) {
                    // テキストを表示する
                    Text("\(timerValue - count)秒")
                    // 文字のサイズを指定
                        .font(.largeTitle)

                    // 水平にレイアウト（横方向にレイアウト）
                    HStack {
                        // スタートボタン
                        Button {
                            // ボタンをタップしたときのアクション
                            // タイマーのカウントダウンを開始する関数を呼び出し
                            startTimer()
                        } label: {
                            Text("スタート")
                            // 文字サイズの指定
                                .font(.title)
                            // 文字色を白に指定
                                .foregroundStyle(Color.white)
                            // 幅と高さを140に指定
                                .frame(width: 140, height: 140)
                            // 背景を設定
                                .background(Color.start)
                            // 円形に切り抜く
                                .clipShape(Circle())
                        }
                        // ストップボタン
                        Button {
                            // ボタンをタップしたときのアクション
                            // timerHandlerをアンラップ
                            if let timerHandler {
                                // タイマーが実行中の場合は停止
                                if timerHandler.isValid {
                                    // タイマー停止
                                    timerHandler.invalidate()
                                }
                            }
                        } label: {
                            Text("ストップ")
                            // 文字サイズの指定
                                .font(.title)
                            // 文字色を白に指定
                                .foregroundStyle(Color.white)
                            // 幅と高さを140に指定
                                .frame(width: 140, height: 140)
                            // 背景を設定
                                .background(Color.stop)
                            // 円形に切り抜く
                                .clipShape(Circle())
                        }
                    }
                    Button("テスト") {

                    }
                    Button {

                    } label: {
                        Text("テスト")
                    }
                }
                
            }
            // 画面が表示されるときに実行される
            .onAppear {
                // カウント（経過時間）の変数を初期化
                count = 0
            }

            // ナビゲーションにボタンを追加
            .toolbar {
                // ナビゲーションバーの右にボタンを追加
                ToolbarItem(placement: .topBarTrailing) {
                    // ナビゲーション遷移
                    NavigationLink {
                        SettingView()
                    } label: {
                        // テキストを表示
                        Text("秒数設定")
                    }
                }
            }
            // 状態変数isShowAlertがtrueになったときに実行
            .alert("終了", isPresented: $isShowAlert) {
                Button("OK") {
                    // OKをタップしたときにここが実効される
                    print("OKがタップされました")
                }
            } message: {
                Text("タイマー終了時間です")
            }
        }
    }

    // 1秒毎に実行されてカウントダウンする
    func countDownTimer () {
        // count（経過時間）に+1していく
        count += 1

        // 残り時間が0以下のとき、タイマーを止める
        if timerValue - count <= 0 {
            // タイマー停止
            timerHandler?.invalidate()

            // アラート表示する
            isShowAlert = true
        }
    }

    // タイマーのカウントダウンを開始する関数
    func startTimer() {
        // timerHandlerをアンラップ
        if let timerHandler {
            // タイマーが実行中の場合、スタートしない
            if timerHandler.isValid {
                return
            }
        }

        // 残り時間が0以下のとき、count(経過時間)を0に初期化する
        if timerValue - count <= 0 {
            count = 0
        }

        // タイマーをスタート
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            // タイマー実行時に呼び出される
            // @Stateプロパティや@AppStorageプロパティはメインスレッドでのみ安全に操作できるため、
            // メインスレッドで実行する必要がある
            Task { @MainActor in
                // 1秒後に実行されてカウントダウンする関数を実行する
                countDownTimer()
            }

        }

    }
}

#Preview {
    ContentView()
}
