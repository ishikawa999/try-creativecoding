BG_R = 0
BG_G = 0
BG_B = 0

class LetterBoxContext
  def set(left_x, top_y, side)
    @left_x = left_x
    @top_y = top_y
    @side = side
  end

  # box内の位置を比率で指定して座標を計算する(毎回座標を書くのは面倒なので)
  def x(horizontal_ratio)
    @left_x + @side * horizontal_ratio
  end

  def y(vertical_ratio)
    @top_y + @side * vertical_ratio
  end

  def length(size_ratio)
    @side * size_ratio
  end
end

def setup
  createCanvas(1200, 300)
  smooth
end

def draw
  # 背景色
  background(BG_R, BG_G, BG_B)
  draw_motion_glow

  # 1文字を描く基準ボックス（正方形）
  letter_box_side = 100.0
  letter_spacing = 20.0
  letter_count = 7

  total_width = letter_count * letter_box_side + (letter_count - 1) * letter_spacing
  first_letter_x = (width - total_width) / 2.0
  first_letter_y = 100.0
  letter_box = LetterBoxContext.new

  draw_word_pass(first_letter_x, first_letter_y, letter_box_side, letter_spacing, letter_box)
end

def ink_blue
  pulse = (Math.sin(frameCount * 0.08) + 1.0) * 0.5
  fill(70, 140, 255, (90 + pulse * 70).to_i)
  stroke(80, 165, 255, (150 + pulse * 80).to_i)
  strokeWeight(2)
end

def ink_purple
  pulse = (Math.sin(frameCount * 0.08 + 1.3) + 1.0) * 0.5
  fill(196, 90, 255, (90 + pulse * 70).to_i)
  stroke(224, 120, 255, (150 + pulse * 80).to_i)
  strokeWeight(2)
end

def draw_motion_glow
  noStroke
  i = 0
  while i < 5
    phase = frameCount * 0.012 + i * 1.2
    x = width * (0.15 + 0.18 * i) + Math.sin(phase) * 24.0
    y = height * (0.28 + 0.08 * i) + Math.cos(phase * 1.3) * 20.0
    size = 140 + Math.sin(phase * 1.7) * 35.0

    if i.even?
      fill(70, 140, 255, 26)
    else
      fill(196, 90, 255, 22)
    end

    circle(x, y, size)
    i += 1
  end
end

# 背景色と同じ色で上書きして消す
def erase_shape
  fill(BG_R, BG_G, BG_B)
  noStroke
end

# "GENUARY" を左から順に描く
def draw_word_pass(first_x, first_y, box_side, letter_spacing, letter_box)
  index = 0
  while index < 7
    letter_left = first_x + index * (box_side + letter_spacing)
    letter_box.set(letter_left, first_y, box_side)

    if index == 0
      draw_g(letter_box)
    elsif index == 1
      draw_e(letter_box)
    elsif index == 2
      draw_n(letter_box)
    elsif index == 3
      draw_u(letter_box)
    elsif index == 4
      draw_a(letter_box)
    elsif index == 5
      draw_r(letter_box)
    else
      draw_y(letter_box)
    end

    index += 1
  end
end

# G: 輪 + 横棒 + 右上を削る
def draw_g(letter_box)
  ink_blue
  ellipse(letter_box.x(0.50), letter_box.y(0.50), letter_box.length(0.82), letter_box.length(0.82))

  erase_shape
  ellipse(letter_box.x(0.50), letter_box.y(0.50), letter_box.length(0.54), letter_box.length(0.54))
  rect(letter_box.x(0.60), letter_box.y(0.28), letter_box.length(0.34), letter_box.length(0.20))

  ink_blue
  rect(letter_box.x(0.50), letter_box.y(0.48), letter_box.length(0.30), letter_box.length(0.10), 4)
end

# E: 太い四角を削って作る
def draw_e(letter_box)
  ink_purple
  rect(letter_box.x(0.14), letter_box.y(0.12), letter_box.length(0.70), letter_box.length(0.76), 8)

  erase_shape
  rect(letter_box.x(0.28), letter_box.y(0.26), letter_box.length(0.60), letter_box.length(0.14), 6)
  rect(letter_box.x(0.28), letter_box.y(0.58), letter_box.length(0.60), letter_box.length(0.14), 6)
end

# N: 縦2本 + 斜め面
def draw_n(letter_box)
  ink_blue
  rect(letter_box.x(0.12), letter_box.y(0.12), letter_box.length(0.14), letter_box.length(0.76), 6)
  rect(letter_box.x(0.74), letter_box.y(0.12), letter_box.length(0.14), letter_box.length(0.76), 6)
  quad(letter_box.x(0.22), letter_box.y(0.18), letter_box.x(0.36), letter_box.y(0.18), letter_box.x(0.80), letter_box.y(0.82), letter_box.x(0.66), letter_box.y(0.82))
end

# U: 縦2本 + 下半分の丸
def draw_u(letter_box)
  ink_purple
  rect(letter_box.x(0.14), letter_box.y(0.12), letter_box.length(0.14), letter_box.length(0.52), 10)
  rect(letter_box.x(0.72), letter_box.y(0.12), letter_box.length(0.14), letter_box.length(0.52), 10)
  arc(letter_box.x(0.50), letter_box.y(0.64), letter_box.length(0.58), letter_box.length(0.52), 0, PI)
end

# A: 三角に横棒
def draw_a(letter_box)
  ink_blue
  triangle(letter_box.x(0.50), letter_box.y(0.10), letter_box.x(0.12), letter_box.y(0.88), letter_box.x(0.88), letter_box.y(0.88))

  erase_shape
  triangle(letter_box.x(0.50), letter_box.y(0.34), letter_box.x(0.33), letter_box.y(0.72), letter_box.x(0.67), letter_box.y(0.72))

  ink_blue
  rect(letter_box.x(0.33), letter_box.y(0.52), letter_box.length(0.34), letter_box.length(0.09), 4)
end

# R: 縦棒 + 丸 + 丸の中心を削る + 三角形
def draw_r(letter_box)
  ink_purple
  rect(letter_box.x(0.14), letter_box.y(0.12), letter_box.length(0.14), letter_box.length(0.76), 6)
  ellipse(letter_box.x(0.46), letter_box.y(0.34), letter_box.length(0.52), letter_box.length(0.40))

  erase_shape
  ellipse(letter_box.x(0.46), letter_box.y(0.34), letter_box.length(0.30), letter_box.length(0.20))

  ink_purple
  triangle(letter_box.x(0.44), letter_box.y(0.50), letter_box.x(0.86), letter_box.y(0.88), letter_box.x(0.66), letter_box.y(0.88))
end

# Y: 逆三角形 + 縦棒
def draw_y(letter_box)
  ink_blue
  triangle(letter_box.x(0.12), letter_box.y(0.12), letter_box.x(0.88), letter_box.y(0.12), letter_box.x(0.50), letter_box.y(0.56))
  rect(letter_box.x(0.43), letter_box.y(0.52), letter_box.length(0.14), letter_box.length(0.36), 6)
end
