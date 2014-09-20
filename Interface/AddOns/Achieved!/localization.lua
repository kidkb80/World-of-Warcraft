
ACHIEVED_STRINGS_CMDLIST = 'Slash commands, to be used in the format "/achd <command>" or "/achieved <command>":';

ACHIEVED_STRINGS_CMD1 = "drag";
ACHIEVED_STRINGS_CMD1_DESC = " Drag the achievement alert frame to a custom position.";
ACHIEVED_STRINGS_CMD2 = "reset";
ACHIEVED_STRINGS_CMD2_DESC = "Reset achievement alert frame to default position.";
ACHIEVED_STRINGS_CMD3 = "anchor";
ACHIEVED_STRINGS_CMD3_ARG = "<loc>";
ACHIEVED_STRINGS_CMD3_ARG1 = "top";
ACHIEVED_STRINGS_CMD3_ARG2 = "bottom";
ACHIEVED_STRINGS_CMD3_ARG3 = "left";
ACHIEVED_STRINGS_CMD3_ARG4 = "right";
ACHIEVED_STRINGS_CMD3_DESC = [[Set frame 2's position, relative to frame 1.
                   For <loc>, use "top", "bottom", "left" or "right".]]
ACHIEVED_STRINGS_CMD4 = "scale";
ACHIEVED_STRINGS_CMD4_ARG = "<#>";
ACHIEVED_STRINGS_CMD4_DESC = [[  Scale the alert frames' size using the given number.
                 1 is 100%, 0.8 is 80%, 1.25 is 125%, etc.]]
ACHIEVED_STRINGS_CMD5 = "save";
ACHIEVED_STRINGS_CMD5_DESC = " Save this character's settings to the default profile.";
ACHIEVED_STRINGS_CMD6 = "load";
ACHIEVED_STRINGS_CMD6_DESC = "  Make this character's settings match the default profile.";
ACHIEVED_STRINGS_CMD7 = "time";
ACHIEVED_STRINGS_CMD7_ARG = "<#>";
ACHIEVED_STRINGS_CMD7_DESC = [[Set how many seconds the alerts remain visible after
              fading in. (Default: 4.05.)]];

ACHIEVED_STRINGS_ALERTFRAME_DRAGGABLE = "Draggable Frame";
ACHIEVED_STRINGS_ALERTFRAME_DRAGGABLE2 = "Alert Frame 2";
ACHIEVED_STRINGS_ALERTFRAME_CLOSE = "Right click when finished";
ACHIEVED_STRINGS_ALERTFRAME_DUNGEON = "Draggable Dungeon Alert";

ACHIEVED_STRINGS_DRAG_ENABLED = "Custom alert frame position enabled.";
ACHIEVED_STRINGS_DRAG_DISABLED = "Alert frame position reset to default.";
ACHIEVED_STRINGS_DRAG_START = "Drag the frames where desired. Right click when finished.";

ACHIEVED_STRINGS_ANCHOR_USAGE = 'Usage: "/achd <loc>" where <loc> is "top", "bottom", "left" or "right".';
ACHIEVED_STRINGS_ANCHOR_SET = "Anchor set to %s.";

ACHIEVED_STRINGS_SCALE_USAGE = 'Usage: "/achd scale <#>" where <#> is a number greater than 0.';
ACHIEVED_STRINGS_SCALE_SET = "Scale set to %s (%s%%).";

ACHIEVED_STRINGS_TIME_USAGE = 'Usage: "/achd time <#>" where <#> is a number greater or equal to 0. (Currently: %s. Default: 4.05.)';
ACHIEVED_STRINGS_TIME_SET = "Visibility time set to %s |4second:seconds;.";

ACHIEVED_STRINGS_DEFAULT_SAVED = "Default profile saved.";
ACHIEVED_STRINGS_DEFAULT_LOADED = "Default profile loaded.";


if (GetLocale() == "koKR") then -- Korean
-- Thanks to Bruteforce (KR-Hellscream) for these translations:
	ACHIEVED_STRINGS_CMDLIST = '슬래시 명령어는 "/achd <명령어>" 또는 "/achieved <명령어>"와 같은 형식으로 사용합니다:';

	ACHIEVED_STRINGS_CMD1 = "drag";
	ACHIEVED_STRINGS_CMD1_DESC = " 업적 경보 프레임을 드래그하여 임의의 위치로 이동합니다.";
	ACHIEVED_STRINGS_CMD2 = "reset";
	ACHIEVED_STRINGS_CMD2_DESC = "업적 경보 프레임을 기본 위치로 초기화 합니다.";
	ACHIEVED_STRINGS_CMD3 = "anchor";
	ACHIEVED_STRINGS_CMD3_ARG = "<loc>";
	ACHIEVED_STRINGS_CMD3_ARG1 = "top";
	ACHIEVED_STRINGS_CMD3_ARG2 = "bottom";
	ACHIEVED_STRINGS_CMD3_ARG3 = "left";
	ACHIEVED_STRINGS_CMD3_ARG4 = "right";
	ACHIEVED_STRINGS_CMD3_DESC = [[프레임 2의 위치를 지정하며, 프레임 1과 연관되어 있습니다.
                   <loc>에는 "top", "bottom", "left" 또는 "right" 명령어로 위치를 지정하세요.]]
	ACHIEVED_STRINGS_CMD4 = "scale";
	ACHIEVED_STRINGS_CMD4_ARG = "<#>";
	ACHIEVED_STRINGS_CMD4_DESC = [[    경보 프레임의 크기를 입력한 숫자로 조절합니다.
                   1은 100%, 0.8은 80%, 1.25는 125%와 같습니다.]]
	ACHIEVED_STRINGS_CMD5 = "save";
	ACHIEVED_STRINGS_CMD5_DESC = " 이 캐릭터의 설정을 기본 프로파일에 저장합니다.";
	ACHIEVED_STRINGS_CMD6 = "load";
	ACHIEVED_STRINGS_CMD6_DESC = " 이 캐릭터의 설정을 기본 프로파일과 동일하게 만듭니다.";

	ACHIEVED_STRINGS_ALERTFRAME_DRAGGABLE = "드래그 프레임";
	ACHIEVED_STRINGS_ALERTFRAME_DRAGGABLE2 = "경보 프레임 2";
	ACHIEVED_STRINGS_ALERTFRAME_CLOSE = "오른쪽 클릭을 하면 완료됩니다.";

	ACHIEVED_STRINGS_DRAG_ENABLED = "임의의 경보 프레임 위치가 활성화 되었습니다.";
	ACHIEVED_STRINGS_DRAG_DISABLED = "경보 프레임 위치가 기본값으로 초기화 되었습니다.";
	ACHIEVED_STRINGS_DRAG_START = "프레임을 원하는 위치로 드래그하세요. 오른쪽 클릭을 하면 완료됩니다.";

	ACHIEVED_STRINGS_ANCHOR_USAGE = '사용법: "/achd <loc>" 여기서 <loc>에는 "top", "bottom", "left" 또는 "right"과 같은 위치 값을 지정합니다.';
	ACHIEVED_STRINGS_ANCHOR_SET = "기준점을 %s로 지정.";

	ACHIEVED_STRINGS_SCALE_USAGE = '사용법: "/achd scale <#>" 여기서 <#>에는 0보다 큰 숫자를 입력합니다.';
	ACHIEVED_STRINGS_SCALE_SET = "크기를 %s (%s%%)로 지정.";

	ACHIEVED_STRINGS_DEFAULT_SAVED = "기본 프로파일에 저장되었습니다.";
	ACHIEVED_STRINGS_DEFAULT_LOADED = "기본 프로파일을 불러왔습니다.";
end
