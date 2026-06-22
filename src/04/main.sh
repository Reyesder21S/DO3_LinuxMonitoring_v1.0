#!/bin/bash

source ./config.cfg

source ./color.sh
source ./data.sh

chmod +x ./data.sh ./color.sh ./config.cfg

DEFAULT_COLUMN1_BACKGROUND=5
DEFAULT_COLUMN1_FONT_COLOR=4
DEFAULT_COLUMN2_BACKGROUND=1
DEFAULT_COLUMN2_FONT_COLOR=3

column1_background=${column1_background:-$DEFAULT_COLUMN1_BACKGROUND}
column1_font_color=${column1_font_color:-$DEFAULT_COLUMN1_FONT_COLOR}
column2_background=${column2_background:-$DEFAULT_COLUMN2_BACKGROUND}
column2_font_color=${column2_font_color:-$DEFAULT_COLUMN2_FONT_COLOR}

if [ $column1_background -eq $column1_font_color ] || [ $column2_background -eq $column2_font_color ]; then
  echo "Цвета шрифта и фона одного столбца не должны совпадать. Пожалуйста, исправьте конфигурационный файл."
  exit 2
fi

bg_title=${bg_colors[$(( $column1_background - 1 ))]}
fg_title=${colors[$(( $column1_font_color - 1 ))]}
bg_value=${bg_colors[$(( $column2_background - 1 ))]}
fg_value=${colors[$(( $column2_font_color - 1 ))]}

get_color_name() {
  local color_code=$1
  case $color_code in
    1) echo "white";;
    2) echo "red";;
    3) echo "green";;
    4) echo "blue";;
    5) echo "purple";;
    6) echo "black";;
    *) echo "unknown";;
  esac
}

get_value_source() {
  local value=$1
  local default=$2
  [ "$value" = "$default" ] && echo "default" || echo "config"
}

col1_bg_name=$(get_color_name $column1_background)
col1_fc_name=$(get_color_name $column1_font_color)
col2_bg_name=$(get_color_name $column2_background)
col2_fc_name=$(get_color_name $column2_font_color)

col1_bg_source=$(get_value_source $column1_background $DEFAULT_COLUMN1_BACKGROUND)
col1_fc_source=$(get_value_source $column1_font_color $DEFAULT_COLUMN1_FONT_COLOR)
col2_bg_source=$(get_value_source $column2_background $DEFAULT_COLUMN2_BACKGROUND)
col2_fc_source=$(get_value_source $column2_font_color $DEFAULT_COLUMN2_FONT_COLOR)

print_system_info

echo
echo "Column 1 background = $column1_background ($col1_bg_name) $col1_bg_source"
echo "Column 1 font color = $column1_font_color ($col1_fc_name) $col1_fc_source"
echo "Column 2 background = $column2_background ($col2_bg_name) $col2_bg_source"
echo "Column 2 font color = $column2_font_color ($col2_fc_name) $col2_fc_source"