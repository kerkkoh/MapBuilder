class MB_CtrlSettingButton: MB_CtrlSettingDefault {
	class Controls: Controls {
		class Title: Title {};
		class Button: MB_CtrlButtonMain {
			idc = 100;
			x = __GUI_SETTING_TEXT_W + __GUI_SETTING_SPACING_X;
			w = __GUI_SETTING_BUTTON_W;
			h = __GUI_SETTING_LINE_H;
		};
	};
};
