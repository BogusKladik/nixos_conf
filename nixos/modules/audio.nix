{ pkgs, lib, ... }:
let webrtcLibPath = lib.makeLibraryPath [ pkgs.webrtc-audio-processing ];
in {
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    wireplumber.enable = true;

    extraConfig.pipewire."10-k670-aec" = {
      "context.modules" = [{
        name = "libpipewire-module-echo-cancel";
        args = {
          "aec.impl" = "webrtc";
          noise-suppression = true;
          agc = true;
          voice-detection = true;

          "capture.props" = { "node.name" = "k670_aec_capture"; };
          "playback.props" = { "node.name" = "k670_aec_playback"; };

          "source.props" = {
            "node.name" = "k670_aec_source";
            "node.description" = "FIFINE K670 (AEC/NS/AGC)";
            "media.class" = "Audio/Source";
          };
          "sink.props" = {
            "node.name" = "k670_aec_sink";
            "node.description" = "AEC Echo Reference";
            "media.class" = "Audio/Sink";
          };
        };
      }];
    };
  };

  systemd.user.services.pipewire.environment = {
    LD_LIBRARY_PATH = webrtcLibPath;
  };
  systemd.user.services.pipewire-pulse.environment = {
    LD_LIBRARY_PATH = webrtcLibPath;
  };
}
