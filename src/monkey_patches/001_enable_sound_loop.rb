class DXOpal::Sound
  # BGM用にループ再生用メソッドを用意
  def loop_play
    raise "Sound #{@path_or_url} is not loaded yet" unless @decoded
    source = nil
    %x{
      var context = #{Sound.audio_context};
      source = context.createBufferSource();
      source.buffer = #{@decoded};
      source.connect(context.destination);
      source.loop = true;
      source.start(0);
    }
    @source = source
  end
end
