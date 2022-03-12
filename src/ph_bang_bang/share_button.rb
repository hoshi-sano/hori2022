# Twitterシェア用ボタンのクラス
class PhBangBang::ShareButton < PhBangBang::Sprite
  URL = "https://hoshi-sano.github.io/hori2022/"
  TEXT_BASE = "score人のファンを魅了しました！"
  HASHTAG = "サイキックヒーツBANGBANG"

  def initialize(x, y, score)
    super(x, y, DXOpal::Image[:share_button])
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
