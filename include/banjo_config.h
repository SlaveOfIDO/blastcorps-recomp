#ifndef __BANJO_CONFIG_H__
#define __BANJO_CONFIG_H__

#include <filesystem>
#include <string>
#include <string_view>

#include "json/json.hpp"

namespace banjo {
    inline const std::u8string program_id = u8"BlastCorpsRecompiled";
    inline const std::string program_name = "BlastCorps: Recompiled";

    namespace configkeys {
        namespace general {
            inline const std::string note_saving_mode = "note_saving_mode";
            inline const std::string camera_invert_mode = "camera_invert_mode";
            inline const std::string analog_cam_mode = "analog_cam_mode";
            inline const std::string third_person_camera_invert_mode = "third_person_camera_invert_mode";
            inline const std::string flying_and_swimming_invert_mode = "flying_and_swimming_invert_mode";
            inline const std::string first_person_invert_mode = "first_person_invert_mode";
            inline const std::string analog_camera_sensitivity = "analog_camera_sensitivity";
        }

        namespace sound {
            inline const std::string bgm_volume = "bgm_volume";
            inline const std::string sfx_volume = "sfx_volume";
        }

        namespace graphics {
            inline const std::string cutscene_aspect_ratio_mode = "cutscene_aspect_ratio_mode";
            inline const std::string native_framerate_mode = "native_framerate_mode";
            inline const std::string draw_distance_mode = "draw_distance_mode";
            inline const std::string fog_distance_mode = "fog_distance_mode";
        }
    }

    // TODO: Move loading configs to the runtime once we have a way to allow per-project customization.
    void init_config();

    enum class CameraInvertMode {
        InvertNone,
        InvertX,
        InvertY,
        InvertBoth
    };

    CameraInvertMode get_camera_invert_mode();

    CameraInvertMode get_third_person_camera_mode();

    CameraInvertMode get_flying_and_swimming_invert_mode();

    CameraInvertMode get_first_person_invert_mode();

    enum class AnalogCamMode {
        On,
        Off,
        OptionCount
    };

    NLOHMANN_JSON_SERIALIZE_ENUM(banjo::AnalogCamMode, {
        {banjo::AnalogCamMode::On, "On"},
        {banjo::AnalogCamMode::Off, "Off"}
    });

    AnalogCamMode get_analog_cam_mode();

    uint32_t get_analog_cam_sensitivity();

    enum class NoteSavingMode {
        Both,
        OnlyJinjos,
        OnlyNotes,
        Off,
        OptionCount
    };

    NLOHMANN_JSON_SERIALIZE_ENUM(banjo::NoteSavingMode, {
        // Keeping as "On" to preserve compatibility with previous configs before jinjo saving
        {banjo::NoteSavingMode::Both,       "On"},
        {banjo::NoteSavingMode::OnlyJinjos, "Jinjos"},
        {banjo::NoteSavingMode::OnlyNotes,  "Notes"},
        {banjo::NoteSavingMode::Off,        "Off"}
    });

    NoteSavingMode get_note_saving_mode();

    enum class CutsceneAspectRatioMode {
        Original,
        Clamp16x9,
        Full,
        OptionCount
    };

    enum class NativeFrameRateMode {
        _30_FPS,
        _60_FPS,
        OptionCount
    };

    enum class DrawDistanceMode {
        Original,
        Extended,
        Extreme,
        OptionCount
    };

    enum class FogDistanceMode {
        Original,
        Extended,
        Extreme,
        OptionCount
    };

    CutsceneAspectRatioMode get_cutscene_aspect_ratio_mode();
    NativeFrameRateMode get_native_framerate_mode();
    DrawDistanceMode get_draw_distance_mode();
    FogDistanceMode get_fog_distance_mode();

    void open_quit_game_prompt();
};

#endif
