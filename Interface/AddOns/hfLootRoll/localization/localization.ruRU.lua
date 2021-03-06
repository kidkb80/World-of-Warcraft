﻿local _, addon = ...;

if ( GetLocale() == "ruRU" ) then
	local L = addon.L;
	
	L["ALL_PASSED"] = "Не разыграно"
L["APPEARANCE"] = "Внешний вид"
L["AUTOCONFIRM"] = "Автоматически подтверждать выбор"
L["AVAILABLE_PRESETS"] = "Список доступных профилей"
L["BACKGROUND"] = "Фон"
L["BAR_COLORS"] = "Фоновые цвета"
L["BAR_OPACITY"] = "Прозрачность панели"
L["BAR_TEXTURE"] = "Фоновая текстура"
L["BAR_TIMER"] = "Фоновый таймер"
L["BEHAVIOR"] = "Поведение"
L["BINDING_HEADER"] = "hfLootRoll"
L["BINDING_OPTIONS"] = "Открыть настройки"
L["BINDING_TOGGLE"] = "Показать/скрыть якорь"
L["BORDER_COLOR"] = "Цвет рамки"
L["BORDER_COLOR_BY_QUALITY"] = "Цвет по качеству"
L["BORDER_OFFSET"] = "Отступ рамки"
L["BORDER_SIZE"] = "Размер рамки"
L["BORDER_TEXTURE"] = "Рамка"
L["BUTTONS_SCALE"] = "Масштаб кнопок"
L["BUTTON_4"] = "Кнопка 4"
L["BUTTON_5"] = "Кнопка 5"
L["BUTTON_LEFT"] = "Левая кнопка"
L["BUTTON_MIDDLE"] = "Средняя кнопка"
L["BUTTON_NA"] = "n/a"
L["BUTTON_RIGHT"] = "Правая кнопка"
L["CLOSE_MOUSE_BUTTON"] = "Кнопка закрытия окна розыгрыша"
L["CLOSE_MOUSE_BUTTON_MODIFIER"] = "Модификатор"
L["COLORS_RESET"] = "Цвета по-умолчанию"
L["COLOR_NAMES_BY_CLASS"] = "Классовые цвета"
L["COMPARISON_TOOLTIP"] = "Автоматически показывать сравнительную подсказку"
L["CONFIG_MODE"] = "Демо режим"
L["CONFIRM_RESET_SETTINGS"] = "Вы действительно хотите сбросить все настройки?"
L["DESCRIPTION"] = "hfLootRoll - аддон, заменяющий стандартные окошки розыгрыша лута. Последнюю версию можно найти на |cff6699ffhttp://www.curse.com|r."
L["DIR_DOWN"] = "Вниз"
L["DIR_UP"] = "Вверх"
L["DISAPPEAR_AFTER_ROLL"] = "Скрыть окно после окончания розыгрыша"
L["DISAPPEAR_AFTER_SELECT"] = "Скрыть окно после сделанного выбора"
L["DISAPPEAR_DELAY"] = "Отсрочка закрытия окна"
L["DISAPPEAR_DELAY_TIME"] = "Задержка (в секундах)"
L["DISAPPEAR_MANUALLY"] = "Только ручное закрытие"
L["FONT"] = "Шрифт"
L["FONT_SIZE"] = "Размер шрифта"
L["GROWTH_DIRECTION"] = "Направление"
L["HEIGHT"] = "Высота"
L["ICON_SCALE"] = "Масштаб иконки"
L["INCOMBAT_CLICKTHROUGH"] = "Разрешить кликать сквозь окно розыгрыша во время боя"
L["INCOMBAT_INTERACTION_MODIFIER"] = "Кнопка принудительного интерактивного режима"
L["INCOMBAT_OPACITY"] = "Прозрачность в бою"
L["ITEM_NAME"] = "Название предмета"
L["ITEM_NAME_COLOR"] = "Цвет"
L["ITEM_NAME_COLOR_BY_QUALITY"] = "Цвет по качеству"
L["JUSTIFY_BOTTOM"] = "Снизу"
L["JUSTIFY_CENTER"] = "По-центру"
L["JUSTIFY_HORIZONTAL"] = "Гориз. выравнивание"
L["JUSTIFY_LEFT"] = "Слева"
L["JUSTIFY_MIDDLE"] = "По-центру"
L["JUSTIFY_RIGHT"] = "Справа"
L["JUSTIFY_TOP"] = "Сверху"
L["JUSTIFY_VERTICAL"] = "Верт. выравнивание"
L["LOCK_FRAMES"] = "Закрепить фреймы"
L["LOOT_SPAM_WARNING"] = "Если вы отключите эту опцию, счетчики в hfLootRoll не будут работать."
L["MAX_FRAMES"] = "Максимальное количество окон розыгрыша"
L["OFFSET"] = "Отступ"
L["OFFSET_X"] = "Гориз. отступ"
L["OFFSET_Y"] = "Верт. отступ"
L["OPEN_SETTINGS"] = "Открыть настройки"
L["OPTIONS_TAB_BORDER"] = "Рамка"
L["OPTIONS_TAB_COLORS"] = "Цвета"
L["OPTIONS_TAB_GENERAL"] = "Основное"
L["OPTIONS_TAB_ITEMNAME"] = "Название предмета"
L["OPTIONS_TAB_POSITION"] = "Расположение"
L["OPTIONS_TAB_TOOLTIPS"] = "Тултип"
L["OPTIONS_TAB_WINNERNAME"] = "Имя победителя"
L["POSITION"] = "Расположение"
L["POSITION_RESET"] = "Сбросить расположение"
L["PRESETS"] = "Профили"
L["PRESET_DELETE"] = "Удалить"
L["PRESET_DELETE_POPUP"] = "Вы уверены, что хотите удалить настройки, связанные с персонажем? (Все настройки %s будут утеряны)"
L["PRESET_LOAD"] = "Загрузить"
L["PRESET_NEW"] = "Новый профиль"
L["PRESET_NEW_POPUP"] = "Введите название для нового профиля (настройки будут скопированиы с текущих)"
L["PRESET_SHARE"] = "Сохранить текущие настройки для всех персонажей"
L["PRESET_SHARE_POPUP"] = "Настройки для всех персонажей будут преписаны, продолжить?"
L["RESIZER_HINT"] = "перетащите для изменения размера"
L["SHOW_BOP"] = "Показывать индикатор БоП вещей"
L["SHOW_ILVL_ICON"] = "Иконка сравнения с одетым предметом"
L["SHOW_ITEM_NAME"] = "Отображать название предмета"
L["SHOW_WHO"] = "Отображать список претендентов"
L["SHOW_WINNER_NAME"] = "Отображать ник подителя розыгрыша"
L["SLASH_AVAILABLE_COMMANDS"] = "допустимые команды"
L["SLASH_LOCK_FRAMES"] = "заблокировать окошко розыгрыша лута"
L["SLASH_OPEN_SETTINGS"] = "открыть окно настроек"
L["SLASH_TOGGLE_FRAMES"] = "показать/скрыть якорь"
L["SLASH_UNLOCK_FRAMES"] = "разблокировать окошко розыгрыша лута"
L["SPARK_OPACITY"] = "Прозрачность блика"
L["TOOLTIPS"] = "Всплывающие подсказки"
L["TOOLTIP_ON_ICON"] = "Всплывающая подсказка только под иконкой"
L["VERSION"] = "Версия"
L["WIDTH"] = "Ширина"
L["WINNER_NAME"] = "Ник победителя розыгрыша"
L["WINNER_NAME_COLOR"] = "Цвет"
L["WINNER_NAME_COLOR_BY_CLASS"] = "Классовый цвет"
L["LootFrameHolder/CLOSE_INFO"] = "Нажмите %s чтобы закрыть этот фрейм"

end