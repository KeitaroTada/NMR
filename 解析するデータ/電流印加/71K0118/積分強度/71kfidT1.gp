# gnuplotグラフ作成用のテンプレート

# ========================================<<初期設定>>========================================

# 初期化
reset

#CSV読み取りに変換
set datafile separator ","

#サイズ指定
set size ratio 1


#ラベル指定
set xlabel font "Helvetica,26"
set ylabel font "Helvetica,26"
# set xlabel offset 0,-2 # x軸ラベルオフセット(適宜調節)
# set ylabel offset -5,0 # y軸ラベルオフセット(適宜調節)

#マージン設定(グラフの余白設定)
set lmargin 25
set bmargin 8
set rmargin 15
set tmargin 3

#軸設定
set tics font "Helvetica,20"
set xtics offset 0,-1
set ytics offset -1,0
set ticscale 2

#枠の設定
set border 15 lw 3 lc rgb "black"


# ========================================<<フィッティング設定>>========================================

#フィッティング
#フィッティングに用いる関数の定義を以下に羅列していく
#ただし、できるだけ、パラメータの初期値を与えておくと推定がすぐに終わる

f(x) = A*exp(-x/B)
A = 1
B = 0.1

h(x) = E*exp(-(x/F)**G)
E = 1
F = 0.01
G = 0.5

#実際のフィッティングは次のように書く
#文法は以下のように書く
#fit [フィッティング範囲] フィッティングに用いる関数 フィッティングするデータ 使用する列 via パラメータ

fit [0.002:0.05] f(x) "71kfidT1_merge.txt" u 2:((2540.66407832592-$3)/2540.66407832592) via A,B
fit h(x) "71kfidT1_merge.txt" u 2:((2540.66407832592-$3)/2540.66407832592) via E,F,G

# 対数軸
set logscale y

# ========================================<<描画設定>>========================================

#表示範囲の指定
set xrange [0:8] # x軸の範囲
set yrange [0.01:1] # y軸の範囲

#set xtics (目盛最小値, 間隔, 目盛最大値)
#set mxtics (主目盛間を何等分するか)
set xtics 0, 1, 8
set mxtics 2

# set xzeroaxis lt 1 lw 3 lc rgb "black"
# set yzeroaxis lt 1 lw 3 lc rgb "black"

#凡例の設定
set key font "Helvetica,22"
set key at 2,0.05
set key reverse
set key spacing 2


# set key reverse # 任意オプション-プロット点と説明の位置を逆にする
# set key spacing 1.5 # 任意オプション-凡例の羅列の間隔を調整する
# set key Left # 凡例の羅列を左揃えにする


# ========================================<<グラフ作成>>========================================

# ,\で区切ることで、複数のグラフを描画できる


plot "71kfidT1_merge.txt" u 2:((2540.66407832592-$3)/2540.66407832592) pt 7 ps 3 lw 1 lc rgb "blue" t " ",\
     [0.002:0.1] f(x) lw 3 lc rgb "red" t " ",\
     h(x) lw 3 lc rgb "black" t " "