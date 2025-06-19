//
//  SettingView.swift
//  MyTimer
//
//  Created by macmini on 2025/06/02.
//

import SwiftUI

struct SettingView: View {
    // 永続化する秒数設定（初期値は10）
    @AppStorage("timer_value") var timerValue = 10
    var body: some View {
        // 奥から手前方向にレイアウト
        ZStack {
            // 背景色表示
            Color.backgroundSetting
                // セーフエリアを超えて画面全体を配置する
                .ignoresSafeArea()

            VStack {
                Spacer()
                Text("\(timerValue)秒")
                    .font(.largeTitle)
                Spacer()
                // Pickerを表示
                Picker(selection: $timerValue) {
                    Text("10")
                        .tag(10)
                    Text("20")
                        .tag(20)
                    Text("30")
                        .tag(30)
                    Text("40")
                        .tag(40)
                    Text("50")
                        .tag(50)
                    Text("60")
                        .tag(60)
                } label: {
                    Text("選択")
                }
                // Pickerをホイール表示
//                .pickerStyle(MenuPickerStyle())
                .pickerStyle(WheelPickerStyle())
//                .pickerStyle(SegmentedPickerStyle())
                Spacer()
            }
        }
    }
}

#Preview {
    SettingView()
}
