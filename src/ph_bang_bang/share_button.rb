# Twitterシェア用ボタンのクラス
class PhBangBang::ShareButton < PhBangBang::Sprite
  IMAGE = Image.new(50, 50, C_WHITE).tap { |img|
    img.draw_font(5, 5, "Tw", Font.default, C_BLACK)
  }
  URL = "https://hoshi-sano.github.io/hori2022/"
  TEXT_BASE = "score人のファンを魅了しました！"
  HASHTAG = "サイキックヒーツBANGBANG"

  def initialize(x, y, score)
    super(x, y, IMAGE)
    @score = score
  end

  def hit
    params = {
      text: TEXT_BASE.gsub(/score/, @score.to_s),
      url: URL,
      hashtags: HASHTAG,
    }
    param_str = params.map { |k, v|
      encoded_val = `encodeURIComponent(#{v})`
      "#{k}=#{encoded_val}"
    }.join("&")
    url = "https://twitter.com/intent/tweet/?#{param_str}"
    `window.open(#{url}, '_blank')`
  end
end
