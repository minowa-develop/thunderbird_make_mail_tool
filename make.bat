setlocal enabledelayedexpansion
CHCP 65001

set CONF_FILE=report.conf
set REPORT_BODY_FILE=report_body.txt

rem 設定項目読込
for /f "tokens=1,* delims==" %%a in (%CONF_FILE%) do (
    set %%a=%%b
)

rem 今日の日付取得
set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

rem subject作成
set SUBJECT=日報：%YEAR%/%MONTH%/%DAY%(%NAME%)

rem 本文取得
set NEW_LINE=%%0A
for /f "delims=α" %%a in (%REPORT_BODY_FILE%) do (
  set line=%%a
  set honbun=!honbun!%%a%NEW_LINE%
)

rem データ注入
set honbun=!honbun:{MONTH}=%MONTH%!
set honbun=!honbun:{DAY}=%DAY%!
set honbun=!honbun:{NAME}=%NAME%!

set honbun_test=aa%%0Abbb

%THUNDERBIRD_HOME% -compose to='%TO%',subject="%SUBJECT%",body="%honbun%"
